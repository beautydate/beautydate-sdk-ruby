module BeautydateApi
  class Object
    attr_accessor :id
    attr_accessor :errors

    def initialize(attributes = {})
      @unsaved_attributes = Set.new
      set_attributes attributes
    end

    def set_attributes(attributes)
      @attributes = attributes
      @attributes.each do |attribute, value|
        add_accessor(attribute)
      end
    end

    def add_accessor(name)
      name = name.to_s
      return if name == 'id'
      singleton_class.class_eval do
        # get
        define_method(name) do 
          self.attributes[name]
        end

        # set
        define_method("#{name}=") do |value|
          self.attributes[name] = value
          self.unsaved_attributes.add name
        end
      end
    end

    def unsaved_attributes
      @unsaved_attributes
    end

    def unsaved_data
      @attributes.slice *@unsaved_attributes
    end

    def attributes
      @attributes
    end

    protected
    def update_attributes_from_result(result)
      set_attributes result["data"]["attributes"]
      id = result["data"]["id"]
    end
  end
end
