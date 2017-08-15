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

      def define_attribute_accessors(new_attributes = nil)
        (new_attributes || @attributes).keys.each do |key|
          next if respond_to?(key)
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

      def assign_attributes(attributes)
        new_attributes = fix_keys(attributes)
        define_attribute_accessors(new_attributes)
        new_attributes.each { |(key, value)| send("#{key}=", value) }
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

      def reset_changes
        @changed = {}
        true
      end

      private

      def fix_keys(hash_to_be_fixed)
        hash_to_be_fixed.each_with_object({}) { |(k, v), hash| hash.merge!(k.to_s => v) }
      end
    end
  end
end
