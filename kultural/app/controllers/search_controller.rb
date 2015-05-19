class SearchController < ApplicationController

  #This return all the PG SEARCH DOCUMENTS, not the actual objects.
  def search
    @search_users = User.search(params[:search_string])
    @search_events = Event.search(params[:search_string])
    @search_places = Place.search(params[:search_string])

    render 'index'
  end
  def autocomplete
    @autocomplete_users = User.search(params[:search_string])
    @autocomplete_events = Event.search(params[:search_string])
    @autocomplete_places = Place.search(params[:search_string])

    respond_to do |format|
      format.js
    end
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search_string)
    end
end
