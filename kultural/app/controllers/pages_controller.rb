class PagesController < ApplicationController
  def main
    redirect_to login_path unless logged_in?
    @places = Place.joins(:events) #.group('places.id').having('count(place_id)>0')
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      #TODO: cambiar a solo eventos futuros.
      marker.lat place.x
      marker.lng place.y
      marker.infowindow render_to_string partial: 'events/list_events', locals: {place: place}
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
