module Constantable
  extend ActiveSupport::Concern

  PHONE_REGEX = /\A\+\d{12}\z/
  PASSWORD_MINIMUM_LENGTH = 6
  NAME_REGEX = /\A[a-zA-Z]+\z/
  PASSWORD_REGEX = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)/
end
