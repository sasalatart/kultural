class Places::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Place.find(params[:place_id])
    end
end
