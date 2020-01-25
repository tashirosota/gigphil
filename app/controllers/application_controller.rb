class ApplicationController < ActionController::Base
  # 一旦ごめん！！
  skip_before_action :verify_authenticity_token

  before_action :authenticate!

  private

  def authenticate!; end

  def current_user
    @current_user ||= User.find session[:user_id]
  end
end
