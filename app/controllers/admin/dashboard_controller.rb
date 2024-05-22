class Admin::DashboardController < ActionController::Base
    layout 'admin'
    before_action :authenticate_user!
    include Pundit::Authorization


    def index
      @devis_count = current_user.role == 'admin' ? Devi.count : current_user.devis.count
      @devis = current_user.devis.order(created_at: :desc).limit(4)
      @users = current_user.role == 'admin' ? User.all.order(created_at: :desc).limit(4) : current_user
      @clients = current_user.clients.order(created_at: :desc).limit(5)
      @factures = Facture.order(created_at: :desc).limit(2)
    end
end
