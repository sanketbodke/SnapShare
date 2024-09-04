# frozen_string_literal: true

class AddPhoneNoToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :string
  end
end
