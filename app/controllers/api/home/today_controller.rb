class Api::TodayController < Api::ApplicationController
  def index
    render json: ScheduleSerializer.new(Schedule.tody).serializable_hash
  end
end
