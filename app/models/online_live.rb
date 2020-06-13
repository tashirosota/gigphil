# == Schema Information
#
# Table name: online_lives
#
#  id            :bigint           not null, primary key
#  title         :string           not null
#  description   :string           not null
#  url           :string           not null
#  is_free       :boolean          default(FALSE), not null
#  broadcasts_at :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OnlineLive < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 40 }
  validates :description, length: { maximum: 200 }
  validates :url, presence: true, format: /\A#{URI.regexp(%w(http https))}\z/
end
