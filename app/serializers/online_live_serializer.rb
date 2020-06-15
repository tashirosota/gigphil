class OnlineLiveSerializer < ApplicationSerializer
  attributes :id, :user_id, :title, :url, :description, :is_free

  attribute :broadcasts_at do |object|
    object.broadcasts_at.in_time_zone('Tokyo').strftime('%m月%d日 %H:%M ~ ')
  end
end
