class ResultsController < ApplicationController
  def index
    @musicbar_id = params[:musicbar_id].present? ? params[:musicbar_id].to_i : nil
    @year = params[:"year(1i)"].to_i
    @month = params[:"month(2i)"].to_i
    @day = params[:is_date_search] == '0' ? params[:"day(3i)"].to_i : nil
    @word = params[:word].presence
    @events =  SearchCommand.new(@musicbar_id, @year, @month, @day ,@word).execute!
    @schedules = Schedule.order("RANDOM()").limit(10)
  end
end
