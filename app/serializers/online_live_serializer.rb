class OnlineLiveSerializer < ApplicationSerializer
  attributes :id, :user_id, :title, :url, :description

  attribute :broadcasts_at do |object|
    object.broadcasts_at.localtime.strftime('%m月%d日 %H:%m ~ ')
  end
end
