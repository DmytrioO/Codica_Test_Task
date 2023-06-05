# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  phone                  :string
#
class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable
end
