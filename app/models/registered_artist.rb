# == Schema Information
#
# Table name: registered_artists
#
#  id                 :bigint           not null, primary key
#  area_id            :bigint           not null
#  registered_user_id :bigint           not null
#  name               :string           not null
#  icon               :string           not null
#  hp                 :string
#  twitter            :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  mv                 :string
#

class RegisteredArtist < ApplicationRecord
  mount_uploader :icon, IconUploader
  has_many :tag_to_registered_artists,
           class_name: 'TagToRegisteredArtist',
           dependent: :nullify,
           inverse_of: :registered_artist
  has_many :tags, through: :tag_to_registered_artists
  has_many :edit_histories, class_name: 'RegisteredArtist::History', dependent: :destroy
  has_many :sounds, class_name: 'RegisteredArtist::Sound', dependent: :destroy, inverse_of: :registered_artist
  has_one :forum, class_name: 'RegisteredArtist::Forum', dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'registered_user_id', inverse_of: :registered_artists
  belongs_to :area
  validates :hp, format: /\A#{URI.regexp(%w(http https))}\z/, allow_blank: true
  validates :twitter, format: /\A#{URI.regexp(%w(http https))}\z/, allow_blank: true
  validates :mv, format: /\A#{URI.regexp(%w(http https))}\z/, allow_blank: true

  def self.new_hash
    {
      id: nil,
      name: nil,
      description: nil,
      icon: nil,
      area: {
        id: nil,
        name: nil
      },
      hp: nil,
      twitter: nil,
      tags: [],
      mv: nil
    }
  end

  def edit_hash
    {
      id: id,
      name: name,
      description: description,
      icon: icon.url,
      area: {
        id: area.id,
        name: area.name
      },
      hp: hp,
      twitter: twitter,
      mv: mv,
      tags: tags.map { |tag| { value: tag.id, label: tag.name } }
    }
  end

  def mv_url
    if mv.blank?
      nil
    elsif mv.match(/embed/)
      mv
    elsif mv.match(/watch/)
      if mv.match(/m.youtube/)
        mv.gsub('m.youtube.com/watch?v=', 'youtube.com/embed/')
      else
        mv.gsub('youtube.com/watch?v=', 'youtube.com/embed/')
      end
    else
      mv.gsub('youtu.be/', 'youtube.com/embed/')
    end
  end
end
