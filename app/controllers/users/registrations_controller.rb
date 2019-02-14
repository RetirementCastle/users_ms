# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json



  def create

    
    begin
      build_resource(sign_up_params)
      resource.save
      render_resource(resource)
    rescue
      render json: { response: { 'Username' => "No valido", 'Code' => 95 }, status: false }
    end

  end

end