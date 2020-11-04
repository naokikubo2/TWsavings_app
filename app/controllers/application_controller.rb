class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :hourly_pay])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :hourly_pay])
    end
end
