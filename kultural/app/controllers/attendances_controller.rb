class AttendancesController < ApplicationController
  def create
    @attendance = Attendance.new()
    @attendance.user_id = params[:user_id]
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
end
