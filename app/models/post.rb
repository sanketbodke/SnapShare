# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_voter
  acts_as_votable

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true, allow_blank: true
end
