module BeautydateApi
  class Business < Core::Resource
    # attr_accessor :uuid

    # def refresh
    #   raise UnkownIdentifierError, 'Business ID or UUID is unknown' unless id || uuid
    #   call('GET', self.class.url(id || uuid))
    # end
    #
    # ##
    # # TODO: change the common operations below to #call (write specs before doing so)
    # ##
    #
    # def create(attributes)
    #   result = Core::Request.request('POST', self.class.endpoint_url, { type: "businesses", attributes: attributes })
    #   self.errors = nil
    #   update_attributes_from_result(result)
    #   true
    # rescue BeautydateApi::RequestWithErrors => e
    #   self.errors = e.errors
    #   false
    # end
    #
    # def update
    #   result = Core::Request.request('PUT', self.class.url(self.id), { type: "businesses", id: self.id, attributes: unsaved_data })
    #   self.errors = nil
    #   update_attributes_from_result(result)
    #   true
    # rescue BeautydateApi::RequestWithErrors => e
    #   self.errors = e.errors
    #   false
    # end
    #
    # def add_trial_days(days, update_data=false)
    #   Core::Request.request('POST', "#{self.class.url(self.id)}/add_trial_days/#{days}")
    #   self.errors = nil
    #   refresh if update_data
    #   true
    # rescue BeautydateApi::RequestWithErrors => e
    #   self.errors = e.errors
    #   false
    # end
    #
    # def manual_payment(status, update_data=false)
    #   status = !!status ? 'enable' : 'disable'
    #   Core::Request.request('PUT', "#{self.class.url(self.id)}/manual_payment/#{status}")
    #   refresh if update_data
    #   self.errors = nil
    #   true
    # rescue BeautydateApi::RequestWithErrors => e
    #   self.errors = e.errors
    #   false
    # end
  end
end
