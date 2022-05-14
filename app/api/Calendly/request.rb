require 'rest-client'

module Calendly
  class Request
    BASE_URL = 'https://api.calendly.com'

    def self.call(http_method:, endpoint:, authorization:, params: {})
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}?#{params.to_query}",
        headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{authorization}" }
      )

      { code: result.code, status: 'Success', data: JSON.parse(result) }
    rescue RestClient::ExceptionWithResponse => e
      { code: e.http_code, status: e.message, data: Error.map(e.http_code) }
    end
  end
end
