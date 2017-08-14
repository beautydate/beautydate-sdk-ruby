module BeautydateApi
  class SalesPayment < Core::Resource
    class << self
      def all
        call('GET', url).dig('data').map { |data| new(data) }
      end

      def find(id)
      end
    end

    # def refresh
    #   raise UnkownIdentifierError, 'SalesPayment ID is unknown' unless id.nil?
    #   call('GET', self.class.url(id))
    # end

    # def update
    #   result = Core::Request.request('PUT', self.class.url(self.id), { type: "businesses", id: self.id, attributes: unsaved_data })
    #   self.errors = nil
    #   update_attributes_from_result(result)
    #   true
    # rescue BeautydateApi::RequestWithErrors => e
    #   self.errors = e.errors
    #   false
    # end
  end
end
