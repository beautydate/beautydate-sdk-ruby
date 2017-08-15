module BeautydateApi
  module Core
    class Resource < Object
      UnkownIdentifierError = Class.new(StandardError)

      class << self
        def all(params = {})
          body = call('GET', url, params: params)
          body.dig('data').map { |data| new('data' => data, 'included' => body['included']) }
        end

        def find(id, params = {})
          raise UnkownIdentifierError, "#{name} ID is unknown" if id.nil?
          body = call('GET', url(id: id), params: params)
          new(body)
        end

        def create(attributes:, relationships: {})
          data = normalize_data(attributes, relationships)
          body = call('POST', url, payload: data)
          new(body)
        end

        def call(method, url, params: {}, payload: {})
          Core::Request.request(method, url, params: params, payload: payload)
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

        def resource_type
          resource_path.underscore
        end

        def resourcify!(name)
          BeautydateApi.const_get(
            name            # "business-payments"
              .singularize  # "business-payment"
              .underscore   # "business_payment"
              .camelize     # "BusinessPayment"
          )
        end

        def normalize_data(attributes, relationships)
          {
            data: {
              type: resource_type,
              attributes: attributes,
              relationships: normalize_relationships(relationships)
            }
          }
        end

        def normalize_relationships(relationships)
          relationships.each_with_object({}) do |(key, value), hash|
            data = { data: { type: key.to_s.pluralize }.merge(value) }
            hash.merge!(key => data)
          end
        end

      end
    end
  end
end
