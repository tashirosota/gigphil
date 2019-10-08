# == Schema Information
#
# Table name: schedules
#
#  id           :integer          not null, primary key
#  music_bar_id :integer          not null
#  event_date   :datetime         not null
#  open         :datetime
#  start        :datetime
#  adv          :integer
#  door         :integer
#  info         :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Schedule < ApplicationRecord
end
