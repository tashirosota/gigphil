class ResultsController < ApplicationController
  def index(musicbar_id, date, word)
    @events =  SearchCommand.execute!(musicbar_id, date, word)
  end
end
