class Events::CommentsController < CommentsController
  before_action :set_commentable

  def index
    @comments = @commentable.comments
  end

  private

    def set_commentable
      @commentable = Event.find(params[:event_id])
    end
end
