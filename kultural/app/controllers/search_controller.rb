class SearchController < ApplicationController

  #This return all the PG SEARCH DOCUMENTS, not the actual objects.
  def search
    @search_users = User.search(params[:search_string])
    @search_events = Event.search(params[:search_string])
    @search_places = Place.search(params[:search_string])

    render 'index'
  end
  def autocomplete
    #results_hash = []
    #@search_results = PgSearch.multisearch(params[:search_string])
    #@search_results.each do |r|
    #  results_hash << {type: r.searchable_type, id: r.searchable_id}
    #end
    #render json: results_hash.to_json
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
