# frozen_string_literal: true
require 'rubygems'
require 'net/ldap'

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create

    begin
      build_resource(sign_up_params)
      resource.save
      render_resource(resource)
      
      ldap = Net::LDAP.new :host => "104.196.22.25",
                 :port => 389,
                 :auth => {
                       :method => :simple,
                       :username => "cn=admin,dc=retirement,dc=unal,dc=edu,dc=co",
                       :password => "admin"
                 }
                 
                  
      if ldap.bind #Si está en el LDAP continua
      
      dn = "cn="+sign_up_params[:email]+",ou=retirement,dc=retirement,dc=unal,dc=edu,dc=co"
      attr = {
        :cn => sign_up_params[:email],
        :objectclass => ["top", "inetorgperson"],
        :sn => sign_up_params[:username],
        :mail => sign_up_params[:email]
      }
        ldap.add( :dn => dn, :attributes => attr )
      else
        render json: { errors: { 'LDAP' => ['Credenciales de Ldap invalidas'] } }, status: :unprocessable_entity
      end
      
      
      
    rescue
      render json: { response: { 'Username' => "No valido", 'Code' => 95 }, status: false }
    end

  end

end