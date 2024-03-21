class Admin::DevisController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_devi, only: %i[ show edit update destroy show_pdf ]

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
        format.html { redirect_to admin_devi_url(@devi), notice: "Devi was successfully created." }
        format.json { render :show, status: :created, location: @devi }
      else
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
        format.html { redirect_to admin_devi_url(@devi), notice: "Devi was successfully updated." }
        format.json { render :show, status: :ok, location: @devi }
      else
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
      format.html { redirect_to admin_devis_url, notice: "Devi was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show_pdf
    authorize @devi
    respond_to do |format|
      format.pdf do
        render pdf: "Devis_#{@devi.id}"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devi
      @devi = Devi.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def devi_params
      params.require(:devi).permit(:client_id, :tva, :status, items_attributes: [:id, :detail, :quantite, :unite, :price, :prix_unitaire_ht, :_destroy])
    end
end
