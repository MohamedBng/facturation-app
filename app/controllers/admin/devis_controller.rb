class Admin::DevisController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_devi, only: %i[show edit update destroy show_pdf create_facture]

  def index
    @devis = current_user.devis
    authorize @devis
  end

  def show
    authorize @devi
  end

  def new
    @devi = current_user.devis.build
    @devi.items.build
    authorize @devi
  end

  def edit
    authorize @devi
  end

  def create
    @devi = current_user.devis.build(devi_params)
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
               formats: [:pdf],
               page_size: 'letter',
               encoding: 'utf8',
               header: {
                  html: {
                    template: 'shared/pdf_header',
                    formats: [:pdf]
                  }
                },
               footer: {
                 html: {
                   template: 'shared/pdf_footer',
                   formats: [:pdf]
                 }
               }
      end
      format.html do
        render template: "admin/devis/show_pdf",
               formats: [:html]
      end
    end
  end


  def create_facture
    authorize @devi

    facture = current_user.factures.build(facture_params_from_devi)
    @devi.items.each do |item|
      facture.items.build(item.attributes.except("id", "created_at", "updated_at", "devi_id", "facture_id"))
    end

    respond_to do |format|
      if facture.save
        format.html { redirect_to [:admin, facture], notice: 'La facture a été créée avec succès depuis le devis.' }
        format.json { render :show, status: :created, location: facture }
      else
        format.html { redirect_to [:admin, @devi], alert: 'La facture n\'a pas pu être créée depuis le devis.' }
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
        provider_id: @devi.provider_id,
        tva: @devi.tva,
        status: @devi.status,
        liquidation_tva: @devi.liquidation_tva,
        number: @devi.provider.factures.last&.number.to_i + 1
      }
    end

    def devi_params
      params.require(:devi).permit(:client_id , :provider_id, :estimated_duration, :duration_unit, :description, :tva, :status, :number, :intervention_location, :vat_application_type, :date_of_creation, :date_of_validity, :start_date_of_service, :payment_terms, :deposit, :total_deposit, :global_discount, :global_discount_type, :global_discount, payment_methods: [], items_attributes: [:id, :detail, :quantite, :unite, :prix_unitaire_ht, :price, :tva, :exempt_tva, :_destroy])
    end
end
