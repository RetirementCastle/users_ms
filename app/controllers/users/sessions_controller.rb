# frozen_string_literal: true
require 'net/ldap'
#require 'devise/strategies/authenticatable'

class Users::SessionsController < Devise::SessionsController
def create
    user = User.find_by_email(sign_in_params[:email])
    
    

    if user && user.valid_password?(sign_in_params[:password])
    
    #if user && user_is_valid?
      @current_user = user
      @current_user.token=@current_user.generate_jwt
      @current_user.save
      render json: { login: { 'user' => @current_user.email, 'token' => @current_user.token }, status: true }
      
    else
      render json: { errors: { 'Credenciales' => ['No validas'] } }, status: :unprocessable_entity
    end
  end
  
  private
  def user_is_valid?
    #LDAP::Conn.new(host = , port = 8085)
    #$HOST =    "104.196.22.25"
    #$PORT =    8085
    #$SSLPORT = LDAP::LDAPS_PORT

#conn = LDAP::Conn.new($HOST, $PORT)
    #puts "hola"
    #ldap = Net::LDAP.new
    #ldap.host = "104.196.22.25"
    #ldap.port = 8085
    #ldap.auth("kherrera", "123456")
    #ldap.bind
  end

end