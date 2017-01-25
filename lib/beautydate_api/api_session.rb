module BeautydateApi
  class APISession

    def authenticate(authorization, email, password)
      request = meta
        .merge(headers(authorization))
        .merge(payload(email, password))

      result = JSON.parse(RestClient::Request.execute request)
      @token_key = result.dig('data', 'attributes', 'token')
      @expires_at = result.dig('data', 'attributes', 'expires_at')

      authenticated?
    rescue => e
      raise AuthenticationException
    end

    def meta
      { method: 'POST', url: "#{BeautydateApi.base_uri}sessions", timeout: 30 }
    end

    def headers(authorization)
      {
        headers: {
          user_agent: "BeautyDate/#{BeautydateApi::VERSION}; Ruby Client",
          content_type: 'application/vnd.api+json',
          authorization: authorization
        }
      }
    end

    def payload(email, password)
      {
        payload: {
          data: {
            type: 'sessions',
            attributes: {
              provider: 'b2beauty', email: email, password: password
            }
          }
        }.to_json
      }
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
