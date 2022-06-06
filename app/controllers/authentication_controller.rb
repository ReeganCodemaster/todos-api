class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser().new(auth_params[:email], auth_params[:password]).call
    json_responses(auth_token: auth_token)
  end
  private
  def auth_paramss
    params.permit(:email, :password)
  end
end
