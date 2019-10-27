class Api::UsersController < Api::ApplicationController
  skip_before_action :authenticate!, only: :create
  
  def create
    render json: UserSerializer.new(User.create_with_tokens!).serializable_hash
  end
end
