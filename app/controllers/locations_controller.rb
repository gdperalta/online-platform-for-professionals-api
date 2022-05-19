class LocationsController < ApplicationController
  def cities
    @cities = PHLocations::Client.getCities

    render json: @cities[:data]
  end

  def regions
    @regions = PHLocations::Client.getRegions

    render json: @regions[:data]
  end
end
