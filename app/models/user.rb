class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password

  has_secure_password

  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  def self.everyone_except(user_id)
    where('id != ?', user_id)
  end
end
