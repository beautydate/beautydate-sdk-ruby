require 'active_support/inflector'
require 'active_support/core_ext/object/blank'
require_relative 'beautydate_api/version'
require_relative 'beautydate_api/object'
require_relative 'beautydate_api/api_resource'
require_relative 'beautydate_api/api_request'
require_relative 'beautydate_api/api_consumer'
require_relative 'beautydate_api/api_session'
require_relative 'beautydate_api/business'
require_relative 'beautydate_api/business_payment'
require_relative 'beautydate_api/device'

# TODO: Replace the lines above by:
#
# Require everything in lib folder, but in random order to find out during
# development if any "require" instructions are missing in any file
# Dir['lib/**/*.rb'].shuffle.each { |path| require path.split('lib/')[-1] }

module BeautydateApi
  @api_version = 'v2'.freeze

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
    attr_reader :api_version
    attr_writer :api_key, :api_email, :api_password, :api_session_token,
                :base_uri

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
      "#{base_uri_without_version}/#{api_version}"
    end

    def base_uri_without_version
      @base_uri || ENV.fetch('BEAUTYDATE_API_BASE_URI')
    end
  end
end
