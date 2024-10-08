# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_voter
  acts_as_votable

  has_many :posts
  has_many :comments
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true
  validates :phone_number, length: { maximum: 10, too_long: 'must be ten digit' }
end
