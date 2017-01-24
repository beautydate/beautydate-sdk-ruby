module BeautydateApi
  class APISession

    def authenticate(authorization, email, password)
      request = {
        method: 'POST',
        url: "#{BeautydateApi.base_uri}sessions",
        timeout: 30,
        headers: {
          user_agent: "BeautyDate/#{BeautydateApi::VERSION}; Ruby Client",
          content_type: 'application/vnd.api+json',
          authorization: authorization
        },
        payload: {
          data: {
            type: 'sessions',
            attributes: {
              provider: 'b2beauty',
              email: email,
              password: password
            }
          }
        }.to_json
      }
      result = JSON.parse(RestClient::Request.execute request)
      @token_key = result['data']['attributes']['token']
      @expires_at = result['data']['attributes']['expires_at']
      true
    rescue => e
      raise AuthenticationException
    end

    def authenticated?
      @token_key && !@token_key.empty?
    end

    def valid?
      authenticated? and Time.now <= Time.at(@expires_at)
    end

    def token
      "Token=#{@token_key}"
    end
  end
end
