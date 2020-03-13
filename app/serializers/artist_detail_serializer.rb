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

  attribute :histories do |object|
    # 一旦空配列
    object.edit_histories.order(created_at: :desc).limit(10).map do |history|
      history.created_at.strftime('%Y/%m/%d %H:%M') + ' 編集が行われました。'
    end + ["#{object.created_at.strftime('%Y/%m/%d %H:%M')} このアーティストが登録されました。"]
  end

  attribute :is_favorite do
    # false
    false
  end

  attribute :mv_url do |object|
    if object.mv.blank?
      nil
    elsif object.mv.match(/embed/)
      object.mv
    elsif object.mv.match(/watch/)
      object.mv.gsub('youtube.com/watch?v=', 'youtube.com/embed/')
    else
      object.mv.gsub('youtu.be/', 'youtube.com/embed/')
    end
  end
end
