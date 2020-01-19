class TimeTablesController < ApplicationController
  def new
    @time_table = TimeTable.default_hash
  end

  def edit
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_hash
  end

  def share
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_hash
  end

  # 保存はここのみで行う
  def create
  params[:time_table]
  end
end
