class OnlineLivesController < ApplicationController
  skip_before_action :authenticate!, only: %i(home index)

  def home
    lives = OnlineLive.where(broadcasts_at: Time.zone.now..).order(broadcasts_at: :asc).limit(20)
    @lives = OnlineLiveSerializer.new(lives).serializable_hash[:data].pluck(:attributes)
  end

  def index
    broadcasts_date = params[:broadcasts_date]
    word = params[:word]
    results = search(broadcasts_date, word)
    @title = "#{broadcasts_date} #{word}の検索結果"
    @lives = OnlineLiveSerializer.new(results).serializable_hash[:data].pluck(:attributes)
  end

  def show
    live = OnlineLive.find params[:id]
    @live = OnlineLiveSerializer.new(live).serializable_hash[:data][:attributes]
    render layout: 'online_live'
  end

  def new; end

  def create
    live = current_user.online_lives.create! live_params
    render json: { id: live.id }
  end

  def destroy
    OnlineLive.find(params[:id]).destroy!
  end

  private

  def live_params
    params[:live].permit(:title, :url, :description, :broadcasts_at, :is_free)
  end

  def search(broadcasts_date, word)
    model = OnlineLive
    if broadcasts_date.present?
      model = model.where("TO_CHAR(broadcasts_at + interval '9 hours','YYYY-MM-DD') = '#{broadcasts_date}'")
    end
    model = model.where('title LIKE :word OR description LIKE :word', word: "%#{word}%") if word.present?
    model.limit(100)
  end
end
