class Admin::ProvidersController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_provider, only: %i[ show edit update destroy ]

  # GET /providers or /providers.json
  def index
    @providers = Provider.all
    authorize @providers
  end

  # GET /providers/1 or /providers/1.json
  def show
    authorize @provider
  end

  # GET /providers/new
  def new
    @provider = Provider.new
    authorize @provider
  end

  # GET /providers/1/edit
  def edit
    authorize @provider
  end

  # POST /providers or /providers.json
  def create
    @provider = Provider.new(provider_params)
    authorize @provider

    respond_to do |format|
      if @provider.save
        format.html { redirect_to admin_provider_url(@provider), notice: "Le provider a été créé avec succès." }
        format.json { render :show, status: :created, location: @provider }
      else
        flash.now[:error] = @provider.errors.full_messages.join(', ')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1 or /providers/1.json
  def update
    authorize @provider
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to admin_provider_url(@provider), notice: "Le provider a été mis à jour avec succès." }
        format.json { render :show, status: :ok, location: @provider }
      else
        flash.now[:error] = @provider.errors.full_messages.join(', ')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1 or /providers/1.json
  def destroy
    authorize @provider
    @provider.destroy!

    respond_to do |format|
      format.html { redirect_to admin_providers_url, notice: "Le provider a été supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  def next_devis_number
    provider = Provider.find(params[:id])
    last_devis = provider.devis.order(number: :desc).first
    next_number = last_devis ? last_devis.number.to_i + 1 : provider.starting_quotation_number
    render json: { next_number: next_number }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provider_params
      params.require(:provider).permit(:name, :address, :city, :postal_code, :num_siret, :logo, :starting_quotation_number)
    end
end
