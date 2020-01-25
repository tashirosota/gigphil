class ResultsController < ApplicationController
  skip_before_action :authenticate!

  def create
  end
  
  def destroy
    session[:user_id] = nil
    head :ok
  end

  private 

  # twitter認証
  def vetify_by_twitter!
    session[:user_id] = User.first.id
  end
end
