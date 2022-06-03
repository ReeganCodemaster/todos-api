class UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.passsword).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response ,:created)
  end

  private
  def usser_params
    params.permit(
      :name, 
      :email,
      :password,
      :password_confirmation
    )
  end
end
