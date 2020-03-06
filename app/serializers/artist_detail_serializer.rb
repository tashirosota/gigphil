class ArtistDetailSerializer < ApplicationSerializer
  attributes :id, :name, :hp, :twitter, :description

  attribute :area do |object|
    object.area.name
  end

  attribute :icon do |object|
    object.icon.url
  end

  attribute :tags do |object|
    object.tags.pluck(:name)
  end

  attribute :sounds do
    # 一旦空配列
    []
  end

  attribute :comments do
    # 一旦空配列
    []
  end

  attribute :histories do
    # 一旦空配列
    []
  end

  attribute :is_favorite do
    # false
    false
  end
end
