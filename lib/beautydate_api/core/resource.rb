module BeautyDateAPI
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

        def update(id, attributes:, relationships: {})
          data = normalize_data(attributes, relationships, id)
          body = call('PATCH', url(id: id), payload: data)
          new(body)
        end

        def call(method, url, params: {}, payload: {})
          Core::Request.request(method, url, params: params, payload: payload)
        end

        def url(id: nil)
          [BeautyDateAPI.base_uri, resource_path, id].compact.join('/')
        end

        def resource_path
          self.name       # BeautyDateAPI::BusinessPayment
            .to_s         # "BeautyDateAPI::BusinessPayment"
            .demodulize   # "BusinessPayment"
            .titleize     # "Business Payment"
            .pluralize    # "Business Payments"
            .parameterize # "business-payments"
        end

        def resource_type
          resource_path.underscore
        end

        def resourcify!(name)
          BeautyDateAPI.const_get(
            name            # "business-payments"
              .singularize  # "business-payment"
              .underscore   # "business_payment"
              .camelize     # "BusinessPayment"
          )
        end

        def normalize_data(attributes, relationships, id = nil)
          {
            data: {
              type: resource_type,
              attributes: attributes,
              relationships: normalize_relationships(relationships)
            }
          }.tap { |body| body[:data][:id] = id.to_s unless id.nil? }
        end

        def normalize_relationships(relationships)
          relationships.each_with_object({}) do |(key, value), hash|
            data = { data: { type: key.to_s.pluralize }.merge(value) }
            hash.merge!(key => data)
          end
        end
      end

      def update(attributes)
        assign_attributes(attributes)
        !changed? || self.class.update(@id, attributes: attributes) && reset_changes
      end
    end
  end
end
