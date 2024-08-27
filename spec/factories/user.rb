# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'testuser' }
    email { 'testuser@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
