module BeautydateApi
  class APIResource < BeautydateApi::Object

    def is_new?
      @attributes['id'].nil?
    end

    class << self
      def url(options=nil)
        endpoint_url + self.relative_url(options)
      end

      def object_type
        self.name.
          to_s.
          gsub(/BeautydateApi::/i, '').
          downcase
      end

      def endpoint_url
        "#{BeautydateApi.base_uri}/#{object_base_uri}"
      end

      def relative_url(options=nil)
        id = case options.class.name
        when 'Hash'
          options[:id] || options["id"]
        when 'Iugu::APIResource'
          options.id
        else
          options
        end
        id ? "/#{id}" : ""
      end

      def object_base_uri
        pluralized_models = %w'business apiconsumer'
        pluralized_models_names = %w'businesses consumers'

        plural_position = pluralized_models.index(self.object_type)
        if plural_position
          pluralized_models_names[plural_position]
        else
          self.object_type + 's'
        end
      end
    end
  end
end
