class Api::ApplicationController < ApplicationController
  before_action :authenticate!
  skip_before_action :verify_authenticity_token, :snakeize_params, :ensure_domain

  attr_reader :current_user

  private

  def authenticate!
    return if Rails.env.development?
    raise AuthenticationError, 'The token is invalid' unless can_authenticate?
  end

  def can_authenticate?
    @current_user = User.authenticate(params[:refresh_token])
  end
end

class AuthenticationError < StandardError; end
