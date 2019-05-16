# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friended_users, through: :friendships
  has_many :friends, foreign_key: :friended_user_id, class_name: 'Friendship'
  has_many :users_who_friended, through: :friendships, source: :user

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  enum status: %i[inactive active]
  has_secure_password

  def email_unconfirmed?
    if status == "inactive"
      true
    else
      false
    end
  end
end
