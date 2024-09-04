# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def otp(user, otp_code)
    @user = user
    @otp_code = otp_code
    mail(to: @user.email, subject: 'Your OTP Code')
  end
end
