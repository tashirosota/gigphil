# == Schema Information
#
# Table name: user_to_schedules
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  schedule_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserToSchedule < ApplicationRecord
  belongs_to :user, class_name: '::User'
  belongs_to :schedule, class_name: '::Schedule'
end
