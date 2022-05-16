class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def render_jsonapi_response(resource, meta: [])
    options = {}
    options[:include] = %i[professional client]
    options[:meta] = meta

    if resource.errors.empty?
      render json: UserSerializer.new(resource, options)
    else
      render json: ErrorSerializer.serialize(resource.errors), status: 400
    end
  end

  protected

  # Additional strong parameters for User Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name contact_number city region role])
  end
end
