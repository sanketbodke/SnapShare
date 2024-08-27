# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user, password: 'oldpassword123') }

  # describe 'PUT #update_password' do
  # context 'with valid current password and valid new password' do
  #   it 'updates the password and returns a success message' do
  #     put :update_password,
  #         params: { id: user.id, current_password: 'oldpassword123', password: 'newpassword123',
  #                   password_confirmation: 'newpassword123' }
  #
  #     expect(response).to have_http_status(:ok)
  #     expect(JSON.parse(response.body)['message']).to eq('Password updated successfully')
  #   end
  # end

  # context 'with invalid current password' do
  #   it 'returns an error message' do
  #     put :update_password,
  #         params: { id: user.id, current_password: 'wrongpassword', password: 'newpassword123',
  #                   password_confirmation: 'newpassword123' }
  #
  #     expect(response).to have_http_status(:unprocessable_entity)
  #     expect(JSON.parse(response.body)['error']).to eq('Current password is incorrect')
  #   end
  # end
  #
  # context 'with non-matching password and password_confirmation' do
  #   it 'does not update the password and returns an error message' do
  #     put :update_password,
  #         params: { id: user.id, current_password: 'oldpassword123', password: 'newpassword123',
  #                   password_confirmation: 'mismatchpassword' }
  #
  #     expect(response).to have_http_status(:unprocessable_entity)
  #     expect(JSON.parse(response.body)['errors']).to include("Password confirmation doesn't match Password")
  #   end
  # end
  #
  # context 'with invalid new password (e.g., too short)' do
  #   it 'does not update the password and returns validation errors' do
  #     put :update_password,
  #         params: { id: user.id, current_password: 'oldpassword123', password: 'short',
  #                   password_confirmation: 'short' }
  #
  #     expect(response).to have_http_status(:unprocessable_entity)
  #     expect(JSON.parse(response.body)['errors']).to include('Password is too short (minimum is 6 characters)')
  #   end
  # end
end
