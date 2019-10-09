# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  access_token_hash  :string           not null
#  refresh_token_hash :string           not null
#  token_expires_at   :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
  has_many :user_to_schedule, class_name: '::UserToSchedule', dependent: :destroy
  has_many :schedules, through: :user_to_schedule

  validates :access_token_hash, format: { with: /\A[0-9a-f]{64}\z/ }, uniqueness: true
  validates :refresh_token_hash, format: { with: /\A[0-9a-f]{64}\z/ }, uniqueness: true

  attr_reader :access_token, :refresh_token

  def access_token=(new_token)
    @access_token = new_token
    self.access_token_hash = User.hash_for(new_token)
  end

  def refresh_token=(new_token)
    @refresh_token = new_token
    self.refresh_token_hash = User.hash_for(new_token)
  end

  class << self
    TIME_TOKEN_LIVES = 30.minutes

    def refresh(ref_token)
      user = find_by!(refresh_token_hash: hash_for(ref_token))
      loop do
        user.access_token = SecureRandom.base58(24)
        user.token_expires_at = TIME_TOKEN_LIVES.since

        break if user.valid?
      end
      user.save!
    end

    def create_with_tokens
      user = new

      loop do
        user.attributes = {
          access_token: SecureRandom.base58(24),
          refresh_token: SecureRandom.base58(24)
        }
        break if user.valid?
      end
      user.save!
    end

    def authenticate(token)
      hsh = hash_for(token)
      find_by('access_token_hash = ? and token_expires_at > ?', hsh, Time.zone.now)
    end

    def hash_for(str)
      Digest::SHA256.hexdigest(str)
    end
  end
end
