class Admin::ClientsController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients or /clients.json
  def index
    @clients = Client.all
    authorize @clients
  end

  # GET /clients/1 or /clients/1.json
  def show
    authorize @client
  end

  # GET /clients/new
  def new
    @client = Client.new
    authorize @client
  end

  # GET /clients/1/edit
  def edit
    authorize @client
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)
    authorize @client

    respond_to do |format|
      if @client.save
        format.html { redirect_to admin_client_url(@client), notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    authorize @client
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to admin_client_url(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    authorize @client
    @client.destroy!

    respond_to do |format|
      format.html { redirect_to admin_clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:nom_complet, :adresse, :ville, :code_postal, :num_siret)
    end
end
