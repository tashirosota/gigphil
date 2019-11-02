class Api::Home::TomorrowController < Api::ApplicationController
  def index
    render json: ScheduleSerializer.new(Schedule.tomorrow).serializable_hash
  end
end
