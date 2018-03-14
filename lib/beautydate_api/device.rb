module BeautydateApi
  class Device < APIResource
    def destroy(id)
      if id.is_a?(Integer) || id.to_s =~ /\A\d+\z/
        call('DELETE', self.class.url(id))
      else
        raise UnkownIdentifierError, "Missing or invalid device ID: #{id}"
      end
    rescue ObjectNotFound
      false
    end
  end
end
