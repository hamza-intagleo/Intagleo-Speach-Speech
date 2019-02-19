# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :require_no_authentication, only: :create
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = User.find_by(email: params[:email])
    if resource.present? && resource.valid_password?(params[:password])
      # set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      # yield resource if block_given?
      render json: resource
      # respond_with resource, location: after_sign_in_path_for(resource)
    else
      render json: { error_messages: "Invalid user name or password" }, status: 404
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
