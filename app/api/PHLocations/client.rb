module PHLocations
    class Client
        def self.getCities
            a = Request.call(http_method: 'get', endpoint: 'cities')
            b = Request.call(http_method: 'get', endpoint: 'cities?page=2')       

            # b[:data].each do |hash|
            #     a[:data].push(hash)
            # end
            
            # a
            a.merge(b) {|key, a, b| a.is_a?(Array) && b.is_a?(Array) ? a | b : b }
        end

        def self.getRegions
            response = Request.call(http_method: 'get', endpoint: 'regions')
        end
    end
end