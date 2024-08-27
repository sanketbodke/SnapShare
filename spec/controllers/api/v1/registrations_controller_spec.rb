# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          user: {
            username: 'testuser',
            email: 'testuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post :create, params: valid_attributes
        end.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['status']).to eq('success')
        expect(JSON.parse(response.body)['message']).to eq('User created successfully.')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          user: {
            username: '',
            email: 'invalidemail',
            password: 'password123',
            password_confirmation: 'wrongconfirmation'
          }
        }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_attributes
        end.not_to change(User, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['message']).to include("Username can't be blank")
        expect(JSON.parse(response.body)['message']).to include('Email is invalid')
        expect(JSON.parse(response.body)['message']).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
