class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :authenticate_user!
  helper_method :current_company
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_company
    current_user.company
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :company_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:company_name])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
