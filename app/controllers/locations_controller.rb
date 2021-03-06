class LocationsController < ApplicationController
  skip_before_action :authenticate_user!

  def cities
    @cities = PHLocations::Client.getCities

    render json: @cities[:data], status: 200
  end

  def regions
    @regions = PHLocations::Client.getRegions

    render json: @regions[:data], status: 200
  end
end
