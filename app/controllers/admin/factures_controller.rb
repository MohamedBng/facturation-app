class Admin::FacturesController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_facture, only: %i[ show edit update destroy show_pdf ]

  # GET /factures or /factures.json
  def index
    @factures = Facture.all
    authorize @factures
  end

  # GET /factures/1 or /factures/1.json
  def show
    authorize @facture
  end

  # GET /factures/new
  def new
    @facture = Facture.new
    @facture.items.build
    authorize @facture
  end

  # GET /factures/1/edit
  def edit
    authorize @facture
  end

  # POST /factures or /factures.json
  def create
    @facture = Facture.new(facture_params)
    authorize @facture

    respond_to do |format|
      if @facture.save
        format.html { redirect_to admin_facture_url(@facture), notice: "La facture a été créée avec succès." }
        format.json { render :show, status: :created, location: @facture }
      else
        flash.now[:error] = @facture.errors.full_messages.join(', ')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factures/1 or /factures/1.json
  def update
    authorize @facture

    respond_to do |format|
      if @facture.update(facture_params)
        format.html { redirect_to admin_facture_url(@facture), notice: "La facture a été mise à jour avec succès." }
        format.json { render :show, status: :ok, location: @facture }
      else
        flash.now[:error] = @facture.errors.full_messages.join(', ')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factures/1 or /factures/1.json
  def destroy
    authorize @facture
    @facture.destroy!

    respond_to do |format|
      format.html { redirect_to admin_factures_url, notice: "La facture a été supprimée avec succès." }
      format.json { head :no_content }
    end
  end

  def show_pdf
    authorize @facture
    respond_to do |format|
      format.pdf do
        render pdf: "Facture_#{@facture.id}",
               template: "admin/factures/show_pdf",
               formats: [:html, :pdf],
               page_size: 'letter',
               encoding: 'utf8',
               footer: {
                  html: {
                    template: 'shared/pdf_footer_facture',
                    formats: [:pdf]
                  }
               }
      end
    end
  end

  private
    def set_facture
      @facture = Facture.find(params[:id])
    end

    def facture_params
      params.require(:facture).permit(:client_id, :tva, :status, :liquidation_tva, items_attributes: [:id, :detail, :quantite, :unite, :price, :prix_unitaire_ht, :_destroy])
    end
end
