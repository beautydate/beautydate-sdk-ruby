module BeautydateApi
  module Core
    class Object
      MEMBERS = {
        top_level: %w(data included),
        data: %w(id type attributes relationships)
      }.freeze

      attr_reader *MEMBERS.values.flatten, :errors, :changed

      def initialize(body)
        @id, @type,
        @attributes,
        @relationships = body['data'].values_at(*MEMBERS[:data])
        @included      = body['included']
        @was           = {}
        @changed       = {}

        define_attribute_accessors
        define_relationship_accessors
      end

      def define_attribute_accessors
        @attributes.keys.each do |key|
          self.singleton_class.class_eval do
            define_method(key)          { @attributes[key] }
            define_method("#{key}_was") { @was[key] }

            define_method("#{key}=") do |value|
              @was[key]        = @attributes[key]
              @attributes[key] = value
              @changed.merge!(key => [@was[key], value])
            end
          end
        end
      end

      def define_relationship_accessors
        !@included.nil? && @relationships.map do |(key, value)|
          next if value['data'].nil?
          type = value.dig('data', 'type')
          data = @included.find { |object| object.slice('id', 'type') == value['data'].slice('id', 'type') }
          body = value.slice('data').deep_merge('data' => data)

          self.singleton_class.class_eval do
            define_method(key) { Resource.resourcify!(type).new(body) }
          end
        end
      end

      def new_record?
        @id.nil?
      end

      def changed?
        !@changed.empty?
      end

      def changes
        @changed.keys
      end
    end
  end
end
