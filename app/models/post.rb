# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true, allow_blank: true
end