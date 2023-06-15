class LocationService < ApplicationService
  def initialize(query:)
    @query = query
  end

  def call
    Rails.cache.fetch(["query",@query], expires_in: 30.minutes, race_condition_ttl: 20.seconds) do 
      Rails.logger.debug("fetching location for #{@query}")
      Geocoder.search(@query, params: {countrycodes: "us", types: 'postcode'}).first.coordinates
    end
  end
end