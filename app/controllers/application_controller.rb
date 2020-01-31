class ApplicationController < ActionController::Base
  before_action :authenticate!, :snakeize_params
  before_filter :ensure_domain
  helper_method :current_user

  private
 
  # redirect correct server from herokuapp domain for SEO
  def ensure_domain
   return unless /\.herokuapp.com/ =~ request.host
   
   # 主にlocalテスト用の対策80と443以外でアクセスされた場合ポート番号をURLに含める 
   port = ":#{request.port}" unless [80, 443].include?(request.port)
   redirect_to "#{request.protocol}www.gigphil.app#{port}#{request.path}", status: :moved_permanently
  end

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
