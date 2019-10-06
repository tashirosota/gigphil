# == Schema Information
#
# Table name: user_to_schedules
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  schedule_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserToSchedule < ApplicationRecord
end
