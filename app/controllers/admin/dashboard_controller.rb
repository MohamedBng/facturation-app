class Admin::DashboardController < ActionController::Base
    layout 'admin'
    before_action :authenticate_user!
    include Pundit::Authorization


    def index
    end
end
