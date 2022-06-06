require 'rails_helper'

RSpec.describe AuthenticationController, type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user)}
    let(:headers) {valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email:user.email,
        password:user.password
      }.to_json
    end
    let(:Invalid_credentails) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # before { allow(request).to recieve(:headers).and_retrun(:headers) }

    context 'when requesst is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'retruns an authentication token' do
        expects(json['auth_token']).not_to be_nil
      end
    end

    context 'when request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'retruns a failure message' do
        expects(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
