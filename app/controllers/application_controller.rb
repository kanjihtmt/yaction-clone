class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'],
    password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
    end
end
