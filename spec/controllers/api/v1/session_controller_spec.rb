# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  # describe 'POST #create' do
  #   let(:user) { create(:user, username: 'testuser', password: 'password123') }
  #
  #   context 'with valid credentials' do
  #     it 'returns a success response and a token' do
  #       post :create, params: { username: 'testuser', password: 'password123' }
  #
  #       expect(response).to have_http_status(:ok)
  #       expect(JSON.parse(response.body)['status']).to eq('success')
  #       expect(JSON.parse(response.body)['message']).to eq('Logged in successfully.')
  #       expect(JSON.parse(response.body)['token']).to be_present
  #     end
  #   end

  context 'with invalid credentials' do
    it 'returns an error response' do
      post :create, params: { username: 'testuser', password: 'wrongpassword' }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['status']).to eq('error')
      expect(JSON.parse(response.body)['message']).to eq('Invalid email or password.')
    end

    it 'returns an error response when the username does not exist' do
      post :create, params: { username: 'nonexistentuser', password: 'password123' }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['status']).to eq('error')
      expect(JSON.parse(response.body)['message']).to eq('Invalid email or password.')
    end
  end
end
