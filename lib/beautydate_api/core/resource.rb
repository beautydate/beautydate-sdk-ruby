module BeautydateApi
  module Core
    class Resource < Object
      UnkownIdentifierError = Class.new(StandardError)

      def call(method, url)
        response = Core::Request.request(method, url)
        self.errors = nil
        update_attributes_from_result(response)
        true
      rescue BeautydateApi::RequestWithErrors => e
        self.errors = e.errors
        false
      end

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
          self.name       # BeautydateApi::BusinessPayment
            .to_s         # "BeautydateApi::BusinessPayment"
            .demodulize   # "BusinessPayment"
            .titleize     # "Business Payment"
            .pluralize    # "Business Payments"
            .parameterize # "business-payments"
        end
      end
    end
  end
end
