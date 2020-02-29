class RegisteredArtist::SearchCommand
  def self.execute!(name, area, tags)
    new(name, area, tags).execute
  end

  def initialize(name, area, tags)
    @name = name
    @area = area
    @tags = tags
  end

  def execute
    # TODO
  end
end
