module BeautydateApi
  module Core
    class Object
      TOP_LEVEL_DATA = %w(id type attributes relationships).freeze

      attr_reader *TOP_LEVEL_DATA, :errors, :changed

      def initialize(data)
        @id, @type, @attributes, @relationships = data.values_at(*TOP_LEVEL_DATA)
        @was     = {}
        @changed = {}
        define_accessors
      end

      def define_accessors
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
