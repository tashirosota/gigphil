# RegisteredArtist::SearchCommand.execute!(params[:artist_name], params[:area], params[:tags])
class RegisteredArtist::SearchCommand
  def self.execute!(name, area, tags)
    new(name, area, tags).execute
  end

  def initialize(name, area_name, tag_names)
    @name = name
    @area = area_name
    @tag_ids = Tag.where(name: tag_names).pluck(:id)
  end

  def execute
    by_tags by_area by_name init_model
  end

  def init_model
    RegisteredArtist.includes(:tags, :area).joins(:tags, :area).order(updated_at: :desc)
  end

  def by_name(model)
    @name.present? ? model.where("registered_artists.name LIKE '%#{@name.gsub('\'', '')}%'") : model
  end

  def by_area(model)
    @area.present? ? model.where("areas.name = '#{@area}'") : model
  end

  def by_tags(model)
    @tag_ids.present? ? model.where("tags.id IN (#{@tag_ids.join(',')})") : model
  end
end
