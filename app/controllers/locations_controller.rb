class LocationsController < ApplicationController
    def cities
        @cities = PHLocations::Client.getCities

        render json: @cities
    end

    def regions
        @regions = PHLocations::Client.getRegions
        
        render json: @regions
    end
end
