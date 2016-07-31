class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = ClientService.all(session[:JSESSIONID])
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
    @users = UserService.all(session[:JSESSIONID]) || []
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create

    @client = ClientService.save(client_params, session[:JSESSIONID])

    respond_to do |format|
      if @client.errors.empty?
        format.html { redirect_to @client, notice: 'Cliente creado exitosamente.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    ClientService.destroy(@client, session[:JSESSIONID])
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = ClientService.find(params[:id], session[:JSESSIONID])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      result = params.require(:client).permit(:first_name, :last_name, :dni)
      result[:user_id] = params.require(:client).permit(:id)[:id]
      result
    end
end
