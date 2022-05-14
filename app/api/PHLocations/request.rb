require 'rest-client'

module PHLocations
  class Request
    BASE_URL = 'https://ph-locations-api.buonzz.com/v1/'

    def self.call(http_method:, endpoint:)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: { 'Content-Type' => 'application/json'}
      )
      
      { code: result.code, status: 'Success', data: JSON.parse(result)['data'] }
    rescue RestClient::ExceptionWithResponse => e
      { code: e.http_code, status: e.message, data: Error.map(e.http_code) }
    end
  end
end