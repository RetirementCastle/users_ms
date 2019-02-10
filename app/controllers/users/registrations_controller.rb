# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json



  def create

    build_resource(sign_up_params)


    puts(resource)
    resource.save

    render_resource(resource)

  end

end