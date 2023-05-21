class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable

  PHONE_REGEX = /\A\+\d{12}\z/
  PASSWORD_MINIMUM_LENGTH = 6
  NAME_REGEX = /\A[a-zA-Z]+\z/
  PASSWORD_REGEX = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)/

  enum :role, %i[patient doctor admin], default: 0

  validates :phone, uniqueness: true, presence: true,  format: { with: PHONE_REGEX }
  validates :password, presence: true, length: { minimum: PASSWORD_MINIMUM_LENGTH }, format: { with: PASSWORD_REGEX }
  validates :first_name, :last_name, presence: true, format: { with: NAME_REGEX }
  validates :second_name, format: { with: NAME_REGEX }, allow_blank: true
end
