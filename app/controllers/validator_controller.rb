class ValidatorController < ApplicationController
    
    def view
        begin
            @u= User.find_by_email(params[:email])
            if @u.token==params[:token]
                render json: { response: { 'user' => @u.email ,  'token' => params[:token] , 'status' => "true", 'message' => "Token Correcto", 'code' => 1} }
            else
                render json: { response: { 'user' => @u.email ,  'token' => params[:token] , 'status' => "false", 'message' => "Token Incorrecto", 'code' => 2} }
            end
        rescue
            render json: { response: { 'user' => params[:email] ,  'token' => params[:token] , 'status' => "false", 'message' => "Usuario no existe", 'code' => 3} }
        end
        
            
    
            
    
        
        
        
    end
    
    private
    
    def validator_params
      # It's mandatory to specify the nested attributes that should be permitted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.require(:validator).permit(:token, :email)
    end
end
