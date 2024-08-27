# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  acts_as_voter
  acts_as_votable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true
end
