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
end
