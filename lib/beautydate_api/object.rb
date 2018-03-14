module BeautydateApi
  class Object
    attr_accessor :id, :attributes, :errors

    def initialize(attributes = {})
      @unsaved_attributes = Set.new
      set_attributes(attributes)
      extract_id_from_attributes
    end

    def set_attributes(attributes)
      @attributes = attributes
      @attributes.each do |attribute, value|
        add_accessor(attribute)
      end
    end

    def add_accessor(attribute)
      attribute = attribute.to_s
      return if attribute == 'id'

      singleton_class.class_eval do
        # get
        define_method(attribute) do
          attributes[attribute] || attributes[attribute.to_sym]
        end

        # set
        define_method("#{attribute}=") do |value|
          self.attributes[attribute] = value
          self.unsaved_attributes.add(attribute)
        end
      end
    end

    def unsaved_attributes
      @unsaved_attributes
    end

    def unsaved_data
      @attributes.select { |key| @unsaved_attributes.include?(key) }
    end

    private

    def extract_id_from_attributes
      @id = @attributes&.delete(:id) || @attributes&.delete('id')
    end

    def update_attributes_from_result(result)
      return if result.blank?
      set_attributes(result.dig('data', 'attributes'))
      @id = result.dig('data', 'id')
    end
  end
end
