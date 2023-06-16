class WeatherController < ApplicationController
  def index
  end
  
  def search
    coords = LocationService.call(query: params[:query])
    @data = WeatherService.call(coords: coords)
    respond_to do |format|
      format.html { head :not_found }
      format.js
    end
  end
end
