class ApplicationController < ActionController::Base
  # 一旦ごめん！！
  skip_before_action :verify_authenticity_token
end
