class StaticsController < ApplicationController
  skip_before_action :authenticate!
  def terms; end

  def privacy; end
end
