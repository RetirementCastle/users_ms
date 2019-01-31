# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
      @current_user.token=@current_user.generate_jwt
      render json: { login: { 'user' => @current_user.email, 'token' => @current_user.token }, status: true }
      
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

end