class Api::Home::TodayController < Api::ApplicationController
  def index
    render json: ScheduleSerializer.new(Schedule.today).serializable_hash
  end
end
