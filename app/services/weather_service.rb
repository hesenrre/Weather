class WeatherService < ApplicationService
  BASE_URI = 'http://api.weatherapi.com/v1/forecast.json'

  def initialize(coords:)
    @coords = coords
    @uri_params = "key=#{Rails.application.credentials.weather[:api_key]}&q=#{@coords.join(',')}&days=10&aqi=yes&alerts=no"
  end

  def call
    Rails.cache.fetch(["coords",@coords], expires_in: 30.minutes, race_condition_ttl: 20.seconds) do 
      current_weather
    end
  end

  def current_weather
    url = "#{BASE_URI}?#{@uri_params}"

    Rails.logger.debug "calling weather service with #{url}"
    response = Faraday.get(url)
    process_response(res: response)
  end

  def process_response(res:)
    return ActiveSupport::JSON.decode(res.body) if res.status == 200

    {}
  end

end