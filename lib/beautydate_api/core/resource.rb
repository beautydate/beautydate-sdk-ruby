module BeautydateApi
  module Core
    class Resource < Object
      UnkownIdentifierError = Class.new(StandardError)
      #
      # def call(method, url)
      #   response = Core::Request.request(method, url)
      #   self.errors = nil
      #   update_attributes_from_result(response)
      #   true
      # rescue BeautydateApi::RequestWithErrors => e
      #   self.errors = e.errors
      #   false
      # end

      class << self
        def call(method, url, params = {})
          Core::Request.request(method, url, params: params)
        end

        def url(id: nil)
          [BeautydateApi.base_uri, object_base_uri, id].compact.join('/')
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
