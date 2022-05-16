module PHLocations
    class Client
        def self.getCities
            response = Request.call(http_method: 'get', endpoint: 'cities')
        end

        def self.getRegions
            response = Request.call(http_method: 'get', endpoint: 'regions')
        end
    end
end