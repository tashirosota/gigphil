class SessionsController < ApplicationController
  skip_before_action :authenticate!

  # twitter認証
  def create
    vetify_by_twitter!
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def register_by_twitter!
    session[:user_id] = User.first.id
    user_data = request.env['omniauth.auth']
    user = User.find_by(uid: user_data[:uid])
    user = unless user
             user = User.create_with_tokens!
             user.name = "#{user_data[:name]}（@#{user_data[:nickname])}）"
             user.provider = user_data[:provider]
             user.uid = user_data[:uid]
             user.save!
             user
           end
    session[:user_id] = user.id
  end
end
