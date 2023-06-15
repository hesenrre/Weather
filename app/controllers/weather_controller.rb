class WeatherController < ApplicationController
  def index
  end
  
  def search
    coords = LocationService.call(query: params[:query])
    @data = WeatherService.call(coords: coords)
  end
end
