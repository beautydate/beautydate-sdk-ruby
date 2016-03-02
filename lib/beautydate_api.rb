#encoding: utf-8
require_relative "beautydate_api/version"
require_relative "beautydate_api/object"
require_relative "beautydate_api/api_resource"
require_relative "beautydate_api/api_request"
require_relative "beautydate_api/api_consumer"
require_relative "beautydate_api/business"

module BeautydateApi
  @api_version = 'v2'
  @endpoint = 'https://beautydate.com.br/api'
  @staging_endpoint = 'https://beta.beautydate.com.br/api'

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
    attr_accessor :api_key
    attr_accessor :staging

    def base_uri
      if !!(@staging || true)
        "#{@staging_endpoint}/#{@api_version}/"
      else
        "#{@endpoint}/#{@api_version}/"
      end
    end
  end
end
