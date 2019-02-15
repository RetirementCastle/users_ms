require 'rubygems'
require 'net/ldap'
class Users::SessionsController < Devise::SessionsController
  def create
    #Obtenemos los datos de usuario
    user = User.find_by_email(sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
            #Seteamos estos datos en un objeto current user
            @current_user = user
            #Validamos el usuario en LDAP
            ldap = Net::LDAP.new :host => "104.196.22.25",
                 :port => 389,
                 :auth => {
                       :method => :simple,
                       :username => "cn=admin,dc=retirement,dc=unal,dc=edu,dc=co",
                       :password => "admin"
                 }
                 
                  
            if ldap.bind #Si está en el LDAP continua
            
            filter = Net::LDAP::Filter.eq( "cn", "kaherreras@unal.edu.co" )
            treebase = "dc=retirement,dc=unal,dc=edu,dc=co"
            
            aux=false
            
            ldap.search( :base => treebase, :filter => filter ) do |entry|
              #puts "DN: #{entry.dn}"
              entry.each do |attribute, values|
                #puts "   #{attribute}:"
                values.each do |value|
                  #puts "      --->#{value}"
                  aux=true
                  
                    #Genera y guarda token
                    @current_user.token=@current_user.generate_jwt
                    @current_user.save
                    break
                  
                  
                end
                break
              end
              break
            end
            if aux
              #Logea
              render json: { login: { 'user' => @current_user.email, 'token' => @current_user.token }, status: true }
            else
              render json: { errors: { 'Credenciales' => ['No validas'] } }, status: :unprocessable_entity
            end
              
            else
              render json: { errors: { 'LDAP' => ['Credenciales de Ldap invalidas'] } }, status: :unprocessable_entity
            end
    else
      render json: { errors: { 'Credenciales' => ['No validas'] } }, status: :unprocessable_entity
    end
    

    #render json: { errors: { 'LDAP' => ['Empieza'] } }, status: :unprocessable_entity
    
  end


end