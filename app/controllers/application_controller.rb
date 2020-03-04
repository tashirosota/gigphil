class ApplicationController < ActionController::Base
  before_action :ensure_domain, :authenticate!, :snakeize_params
  helper_method :current_user, :logined?
  add_flash_types :secondary

  private

  # redirect correct server from herokuapp domain for SEO
  def ensure_domain
    return if Rails.env.staging?
    return unless /\.herokuapp.com/ =~ request.host

    # 主にlocalテスト用の対策80と443以外でアクセスされた場合ポート番号をURLに含める
    port = ":#{request.port}" unless [80, 443].include?(request.port)
    redirect_to "#{request.protocol}www.gigphil.app#{port}#{request.path}", status: :moved_permanently
  end

  def authenticate!
    raise AuthenticationError unless current_user
  end

  def current_user
    @current_user ||= User.first || User.find_by(id: session[:user_id])
  end

  def logined?
    !!current_user
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
