# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_voter
  acts_as_votable

  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true
end
