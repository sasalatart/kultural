class AttendancesController < ApplicationController
  before_action :logged_in_user
  before_action :current_user_is_attendant?, only: [:destroy]

  def create
    @attendance = Attendance.new()
    @attendance.user = current_user
    @attendance.event_id = params[:event_id]
    @attendance.save

    @event = Event.find(params[:event_id]);
    render 'press_attendance_button.js'
  end

  def destroy
    Attendance.find(params[:id]).destroy
    @event = Event.find(params[:event_id])
    render 'press_attendance_button.js'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendances_params
      params.require(:attendance).permit(:user_id, :event_id)
    end

    def current_user_is_attendant?
      unless Attendance.find(params[:id]).user == current_user
        respond_to do |format|
          format.js {render js: "alert('Bad guy!');"}
        end
      end
    end
end
