# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_voter
  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true, allow_blank: true
end
