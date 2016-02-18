require_relative "beautydate_api/api_resource"
require_relative "beautydate_api/business"
require_relative "beautydate_api/consumer"

module BeautydateApi
  @api_version = 'v2'
  @endpoint = 'https://beautydate.com/api'
  @staging_endpoint = 'https://beta.beautydate.com/api'

  class << self
    attr_accessor :api_key
    attr_accessor :staging

    def base_uri
      if !!@staging
        "#{@endpoint}/#{@api_version}/"
      else
        "#{@staging_endpoint}/#{@api_version}/"
      end
    end
  end
end
