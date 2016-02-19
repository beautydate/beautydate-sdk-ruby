module BeautydateApi
  class APIConsumer

    def authenticate token
      request = { 
        method: 'POST',
        url: "#{BeautydateApi.base_uri}consumers/auth",
        timeout: 30,
        headers: {
          user_agent: "Beauty Date Ruby Client #{BeautydateApi::VERSION}",
          content_type: 'application/vnd.api+json'
        },
        payload: {
          data: {
            type: 'consumers',
            attributes: {
              uuid: token
            }
          }
        }.to_json
      }

      result = JSON.parse(RestClient::Request.execute request)
      @bearer_key = result["data"]["attributes"]["token"]
      @expires_at = result["data"]["attributes"]["token_expires_at"]
      self
    rescue
      raise AuthenticationException
    end

    def authenticated?
      @bearer_key.present?
    end

    def valid?
      authenticated? and Time.now <= Time.at(@expires_at)
    end

    def bearer
      "Bearer #{@bearer_key}"
    end
  end
end
