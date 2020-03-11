class SessionsController < ApplicationController
  skip_before_action :authenticate!

  # twitter認証
  def create
    register_by_twitter!
    redirect_to root_path, secondary: 'ログインしました'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, secondary: 'ログアウトしました'
  end

  private

  def register_by_twitter! # rubocop:disable  Metrics/AbcSize
    user_data = request.env['omniauth.auth']
    user = User.find_by(uid: user_data[:uid])
    unless user
      user = User.create_with_tokens!
      user.username = user_data[:info][:nickname]
      user.provider = user_data[:provider]
      user.uid = user_data[:uid]
      user.icon_url = user_data[:extra][:raw_info][:profile_image_url_https]
      user.save!
      user
    end
    user.update!(icon_url: user_data[:extra][:raw_info][:profile_image_url_https])
    session[:user_id] = user.id
  end
end
