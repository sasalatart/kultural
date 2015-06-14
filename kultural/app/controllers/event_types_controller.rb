class EventTypesController < ApplicationController
  before_action :set_event_type, only: [:show]

  def index
    @event_types = EventType.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_type
      @event_type = EventType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_type_params
      params.require(:event_type).permit(:name, :examples)
    end
  end
