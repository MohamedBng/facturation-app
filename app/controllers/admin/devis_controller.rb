class Admin::DevisController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_devi, only: %i[ show edit update destroy show_pdf create_facture ]

  # GET /devis or /devis.json
  def index
    @devis = Devi.all
    authorize @devis
  end

  # GET /devis/1 or /devis/1.json
  def show
    authorize @devi
  end

  # GET /devis/new
  def new
    @devi = Devi.new
    @devi.items.build
    authorize @devi
  end

  # GET /devis/1/edit
  def edit
    authorize @devi
  end

  # POST /devis or /devis.json
  def create
    @devi = Devi.new(devi_params)
    authorize @devi

    respond_to do |format|
      if @devi.save
        format.html { redirect_to admin_devi_url(@devi), notice: "Le devis a été créé avec succès." }
        format.json { render :show, status: :created, location: @devi }
      else
        flash.now[:error] = @devi.errors.full_messages.join(', ')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @devi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devis/1 or /devis/1.json
  def update
    authorize @devi

    respond_to do |format|
      if @devi.update(devi_params)
        format.html { redirect_to admin_devi_url(@devi), notice: "Le devis a été mis à jour avec succès." }
        format.json { render :show, status: :ok, location: @devi }
      else
        flash.now[:error] = @devi.errors.full_messages.join(', ')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @devi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devis/1 or /devis/1.json
  def destroy
    authorize @devi
    @devi.destroy!

    respond_to do |format|
      format.html { redirect_to admin_devis_url, notice: "Le devis a été supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  def show_pdf
    authorize @devi
    respond_to do |format|
      format.pdf do
        render pdf: "Devis_#{@devi.id}",
               template: "admin/devis/show_pdf",
               formats: [:html, :pdf],
               page_size: 'letter',
               encoding: 'utf8',
               footer: {
                 html: {
                   template: 'shared/pdf_footer',
                   formats: [:pdf]
                 }
               }
      end
    end
  end

  def create_facture
    authorize @devi

    facture = Facture.new(facture_params_from_devi)
    @devi.items.each do |item|
      facture.items.build(item.attributes.except("id", "created_at", "updated_at", "devi_id", "facture_id"))
    end

    respond_to do |format|
      if facture.save
        format.html { redirect_to [:admin, facture], notice: 'Facture was successfully created from the devi.' }
        format.json { render :show, status: :created, location: facture }
      else
        flash.now[:error] = facture.errors.full_messages.join(', ')
        format.html { redirect_to [:admin, @devi], alert: 'Failed to create facture from devi.' }
        format.json { render json: facture.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devi
      @devi = Devi.find(params[:id])
    end

    def facture_params_from_devi
      {
        client_id: @devi.client_id,
        tva: @devi.tva,
        status: @devi.status,
        liquidation_tva: @devi.liquidation_tva
      }
    end

    # Only allow a list of trusted parameters through.
    def devi_params
      params.require(:devi).permit(:client_id, :tva, :status, :liquidation_tva, items_attributes: [:id, :detail, :quantite, :unite, :price, :prix_unitaire_ht, :_destroy])
    end
end
