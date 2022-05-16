require 'rest-client'

module Calendly
  class Request
    BASE_URL = 'https://api.calendly.com'

    def self.call(http_method:, endpoint:, authorization:, params: {}, payload: '')
      response = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}?#{params.to_query}",
        payload: payload,
        headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{authorization}" }
      )
      result = response == '' ? response : JSON.parse(response)

      { code: response.code, status: 'Success', data: result }
    rescue RestClient::ExceptionWithResponse => e
      { code: e.http_code, status: e.message, data: Error.map(e.http_code) }
    end
  end
end
