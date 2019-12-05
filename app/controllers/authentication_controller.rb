class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    user = User.where(email: auth_params[:email]).first
    json_response(auth_token: auth_token, role: user.role, email: user.email, id: user.id)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end