module BeautydateApi
  class APIResource < BeautydateApi::Object

    def is_new?
      @attributes['id'].nil?
    end

    class << self
      def url(options=nil)
        endpoint_url + self.relative_url(options)
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
        self.name
          .to_s
          .demodulize
          .tableize
          .titleize
          .parameterize
      end
    end
  end
end
