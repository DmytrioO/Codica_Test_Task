# == Schema Information
#
# Table name: conclusions
#
#  id              :bigint           not null, primary key
#  recommendations :text             not null
#  appointment_id  :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Conclusion < ApplicationRecord
  belongs_to :appointment

  validates :recommendations, presence: true
end
