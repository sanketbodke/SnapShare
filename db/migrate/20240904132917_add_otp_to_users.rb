# frozen_string_literal: true

class AddOtpToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :otp_code, :string
    add_column :users, :otp_generated_at, :datetime
  end
end
