module BeautyDateAPI
  module Core
    class Consumer

      def authenticate token
        request = {
          method: 'POST',
          url: "#{BeautyDateAPI.base_uri}/consumers/auth",
          timeout: 30,
          headers: {
            user_agent: "BeautyDate/#{BeautyDateAPI::VERSION}; Ruby Client",
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
        @bearer_key = result.dig('data', 'attributes', 'token')
        @expires_at = result.dig('data', 'attributes', 'token_expires_at')
        true
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
end
