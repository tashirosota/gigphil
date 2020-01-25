class ResultsController < ApplicationController
  skip_before_action :authenticate!
  before_action :set_instances

  def index
    set_search_content
    @schedules = Schedule::SearchCommand.new(@musicbar_id, @year, @month, @day, @word).execute!
  end

  private

  # rubocop:disable Metrics/AbcSize
  def set_instances
    @musicbar_id = params[:musicbar_id].present? ? params[:musicbar_id].to_i : nil
    @musicbar_name = params[:musicbar_id].present? ? MusicBar.find(params[:musicbar_id]).name : nil
    @year = params[:"year(1i)"].to_i
    @month = params[:"month(2i)"].to_i
    @day = params[:is_date_search] == '0' ? params[:"day(3i)"].to_i : nil
    @word = params[:word].presence
  end
  # rubocop:enable Metrics/AbcSize

  def set_search_content
    str = "検索内容: #{@year}/#{@month}#{@day ? ('/' + @day.to_s) : ''} #{@musicbar_name.presence} #{@word.presence}"
    @search_content = str
  end
end
