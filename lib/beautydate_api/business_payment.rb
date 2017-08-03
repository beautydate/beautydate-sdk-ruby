module BeautydateApi
  class BusinessPayment < Core::Resource
    def create(attributes)
      result = Core::Request.request('POST', self.class.endpoint_url, create_params(attributes))
      self.errors = nil
      update_attributes_from_result result
      true
    rescue BeautydateApi::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    private

    def create_params(attributes)
      business_id = attributes.delete(:business_id)
      business_plan_id = attributes.delete(:business_plan_id)

      {
        type: 'business_payments',
        attributes: attributes,
        relationships: {
          business: { data: { type: 'businesses', id: business_id } },
          business_plan: { data: { type: 'business_plans', id: business_plan_id } }
        }
      }
    end
  end
end
