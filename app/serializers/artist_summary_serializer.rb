# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  access_token_hash  :string           not null
#  refresh_token_hash :string           not null
#  token_expires_at   :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  provider           :string
#  uid                :string
#  username           :string
#

class ArtistSummarySerializer
  include FastJsonapi::ObjectSerializer
end
