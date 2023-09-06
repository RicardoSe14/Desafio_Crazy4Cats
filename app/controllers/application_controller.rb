class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname, :nickname, images: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :lastname, :nickname, images: []])
    end

    def authorize_request(kind = nil)
        unless kind.include?(current_user.role)
        redirect_to articles_path, notice: "Usted no esta autorizado a realizar esta acción"
        end
    end
end