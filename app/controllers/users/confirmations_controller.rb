# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    render json: UserSerializer.new(resource)
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(_resource_name, _resource)
  #   super(resource_name, resource)
  # end
end
