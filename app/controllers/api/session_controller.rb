class Api::SessionController < Api::ApplicationController
  skip_before_action :authenticate!, only: :update

  def update
    render json: UserSerializer.new(User.refresh!(params[:refresh_token])).serializable_hash
  end
end
