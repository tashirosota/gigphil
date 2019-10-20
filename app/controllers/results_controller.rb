class ResultsController < ApplicationController
  def index
    @musicbar_id = params[:musicbar_id].present? ? params[:musicbar_id].to_i : nil
    @musicbar_name = params[:musicbar_id].present? ? MusicBar.find(params[:musicbar_id]).name : nil
    @year = params[:"year(1i)"].to_i
    @month = params[:"month(2i)"].to_i
    @day = params[:is_date_search] == '0' ? params[:"day(3i)"].to_i : nil
    @word = params[:word].presence
    @schedules =  SearchCommand.new(@musicbar_id, @year, @month, @day ,@word).execute!
    @search_content =  "検索内容: #{@year}/#{@month}#{@day ? ('/' + @day.to_s) : ''} #{@musicbar_name.presence} #{@word.presence}"
  end
end
