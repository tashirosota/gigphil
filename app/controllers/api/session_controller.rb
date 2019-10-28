class Api::SessionController < Api::ApplicationController
  skip_before_action :authenticate!, only: :update

  def update(refresh_token)
    render json: UserSerializer.new(User.refresh!(refresh_token)).serializable_hash
  end
end
