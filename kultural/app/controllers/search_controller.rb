class SearchController < ApplicationController

  #This return all the PG SEARCH DOCUMENTS, not the actual objects.
  def search
    @search_results = PgSearch.multisearch(params[:search_string])
    render 'index'
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:search_string)
    end
end
