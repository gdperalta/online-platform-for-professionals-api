module PHLocations
    class Client
        def self.getCities
            a = Request.call(http_method: 'get', endpoint: 'cities')
            b = Request.call(http_method: 'get', endpoint: 'cities?page=2')
            response = {a,**b}
        end

        def self.getRegions
            response = Request.call(http_method: 'get', endpoint: 'regions')
        end
    end
end