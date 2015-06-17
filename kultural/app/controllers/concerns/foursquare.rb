module Foursquare
  extend ActiveSupport::Concern

  class FoursquareVenueAPI
    
    include HTTParty
    base_uri 'https://api.foursquare.com'

    def initialize
      @options = {
        v: '20150616',
        client_id: ENV['FOURSQUARE_CLIENT_ID'],
        client_secret: ENV['FOURSQUARE_CLIENT_SECRET']
      }
    end

    def search(params = {ll: '0,0'})
      params.merge!(@options)
      self.class.get('/v2/venues/search', { query: params })
    end

    def get(id)
      self.class.get("/v2/venues/#{id.to_s}", { query: @options })
    end
  end

  def get_place_info(lat, long, name)
    api = FoursquareVenueAPI.new
    params = {
      ll: "#{lat},#{long}",
      query: name
    }

    search = api.search params

    if search.code == 200 and search['response'].any?
      id = search['response']['venues'].first['id']
      venue = api.get id

      if venue.code == 200
        data = venue['response']['venue']
        return {
          name: data['name'],
          address: data['location']['formattedAddress'].join(", "),
          categories: data['categories'].map {|o| o['name']}.join(", "),
          checkins: data['stats']['checkinsCount'],
          likes: data['likes']['count'],
          photo: get_photo_url(data['bestPhoto'])
        }
      end
    end
  end

  private

  def get_photo_url(photo)
    unless photo.nil?
      "#{photo['prefix']}300x300#{photo['suffix']}"
    end
  end
end