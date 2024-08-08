class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    self.resource = warden.authenticate!(auth_options)

    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new", company_name: params[:user][:company_name] }
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:company_name])
  end
end
