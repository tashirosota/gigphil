# == Schema Information
#
# Table name: time_table_rehearsals
#
#  id                  :bigint           not null, primary key
#  time_table_id       :bigint           not null
#  order               :integer          not null
#  band_name           :string           not null
#  custom_play_time    :integer
#  custom_setting_time :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class TimeTable::Rehearsal < ApplicationRecord
  belongs_to :time_table
end
