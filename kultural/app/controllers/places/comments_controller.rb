class Places::CommentsController < CommentsController
  before_action :set_commentable

  def index
    @comments = @commentable.comments
  end

  private

    def set_commentable
      @commentable = Place.find(params[:place_id])
    end
end
