class ApplicationController < ActionController::Base
  before_action :authenticate!, :snakeize_params
  helper_method :current_user

  private

  def authenticate!
    raise AuthenticationError unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def snakeize_params
    params.deep_snakeize!
  end
end

class AuthenticationError < StandardError
  def initialize(msg = '')
    message = msg.presence || 'need authentication by twitter'
    super message
  end
end
