class ArtistSummarySerializer < ApplicationSerializer
  attributes :id, :name

  attribute :area do |object|
    object.area.name
  end

  attribute :icon do |object|
    object.icon.url
  end

  attribute :tags do |object|
    object.tags.limit(3).pluck(:name)
  end
end
