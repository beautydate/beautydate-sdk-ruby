module BeautydateApi
  module Core
    class Resource < Object
      UnkownIdentifierError = Class.new(StandardError)

      class << self
        def all(params = {})
          body = call('GET', url, params)
          body.dig('data').map { |data| new('data' => data, 'included' => body['included']) }
        end

        def find(id, params = {})
          raise UnkownIdentifierError, "#{name} ID is unknown" if id.nil?
          body = call('GET', url(id: id), params)
          new(body)
        end

        def call(method, url, params = {})
          Core::Request.request(method, url, params: params)
        end

        def url(id: nil)
          [BeautydateApi.base_uri, resource_path, id].compact.join('/')
        end

        def resource_path
          self.name       # BeautydateApi::BusinessPayment
            .to_s         # "BeautydateApi::BusinessPayment"
            .demodulize   # "BusinessPayment"
            .titleize     # "Business Payment"
            .pluralize    # "Business Payments"
            .parameterize # "business-payments"
        end

        def resourcify!(name)
          BeautydateApi.const_get(
            name            # "business-payments"
              .singularize  # "business-payment"
              .underscore   # "business_payment"
              .camelize     # "BusinessPayment"
          )
        end
      end
    end
  end
end
