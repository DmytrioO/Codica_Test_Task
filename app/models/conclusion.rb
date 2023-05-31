class Conclusion < ApplicationRecord
  belongs_to :appointment

  validates :recommendations, presence: true
end
