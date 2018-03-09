require 'active_support/inflector'
require 'active_support/core_ext/object/blank'
require_relative 'beautydate_api/version'

require_relative 'beautydate_api/core/object'
require_relative 'beautydate_api/core/resource'
require_relative 'beautydate_api/core/request'
require_relative 'beautydate_api/core/consumer'
require_relative 'beautydate_api/core/session'

require_relative 'beautydate_api/business'
require_relative 'beautydate_api/business_payment'
require_relative 'beautydate_api/sales_payment'

module BeautyDateAPI
  @api_version = 'v2'.freeze
  @endpoint = 'https://beautydate.com.br/api'.freeze

  class AuthenticationException < StandardError
  end

  class RequestFailed < StandardError
  end

  class ObjectNotFound < StandardError
  end

  class RequestWithErrors < StandardError
    attr_accessor :errors

    def initialize(errors)
      @errors = errors
    end
  end

  class << self
    attr_accessor :staging
    attr_writer :api_key, :api_email, :api_password, :api_session_token

    def staging_endpoint
      @staging_endpoint ||= ENV.fetch('BEAUTYDATE_API_STAGING_ENDPOINT', 'https://beta.beautydate.com.br/api')
    end

    def api_key
      @api_key || ENV.fetch('BEAUTYDATE_API_KEY')
    end

    def api_email
      @api_email || ENV.fetch('BEAUTYDATE_API_EMAIL')
    end

    def api_password
      @api_password || ENV.fetch('BEAUTYDATE_API_PASSWORD')
    end

    def api_session_token
      @api_session_token || ENV.fetch('BEAUTYDATE_API_SESSION_TOKEN')
    end

    def base_uri
      @staging = true if @staging.nil? # default environment
      if @staging
        "#{staging_endpoint}/#{@api_version}"
      else
        "#{@endpoint}/#{@api_version}"
      end
    end
  end
end
