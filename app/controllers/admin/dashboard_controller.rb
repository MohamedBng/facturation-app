class Admin::DashboardController < ActionController::Base
    layout 'admin'
    before_action :authenticate_user!
    include Pundit::Authorization


    def index
      @devis = Devi.order(created_at: :desc).limit(4)
      @users = User.order(created_at: :desc).limit(5)
      @clients = Client.order(created_at: :desc).limit(5)
      @factures = Facture.order(created_at: :desc).limit(2)
    end
end
