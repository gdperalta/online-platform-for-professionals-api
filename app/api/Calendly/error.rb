module Calendly
  class Error
    def self.map(code)
      case code
      when 404
        'Not found'
      when 401
        'Unauthorized request! Please try again'
      else
        'Invalid Request'
      end
    end
  end
end
