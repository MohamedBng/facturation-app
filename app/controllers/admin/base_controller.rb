class Admin::BaseController < ActionController::Base
    before_action :authenticate_user!
    include Pundit::Authorization

    private

    def after_sign_in_path_for(resource)
        admin_dashboard_path
    end
end
