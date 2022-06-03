require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) {creatae_user(:user)}
  subject(:valid_auth_obj) { described_class.new(user.email, user.password)}
  subject(:invalid_auth_obj) {described_class.new('foo','bar')}

  describe '#call' do
    context 'when valid credentails' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end
     context 'when invalid credentails' do
      it 'raises an authentication error' do
        expect {invalid_auth_obj.call }
          .to raises_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentails/
          )
      end
     end
  end
end