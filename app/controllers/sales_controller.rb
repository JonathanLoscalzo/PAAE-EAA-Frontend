class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :update, :destroy]
  before_action :set_persist_model, only: [:persist]
  skip_before_action :require_login, only: [:new]
  before_action :set_service

  def set_service
    @saleService = SaleService.new(session[:JSESSIONID])
    @paymentService = PaymentFormService.new(session[:JSESSIONID])
  end

  # GET /sales
  # GET /sales.json
  def index
    @sales = @saleService.all
    @payments = @paymentService.all
    @clients = ClientService.all(session[:JSESSIONID])
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  def client_sales
    @saleService.all_client_sales(session[:client_id])
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @payment_forms = @paymentService.all
    @clients = ClientService.all(session[:JSESSIONID])
  end

  # GET /sales/1/edit
  def edit
    str = '{"fecha":"2015-01-01","nro":"123","cliente":{"id": "2"},"detalles":[{"cantidad":"20","fila": 1,"producto": {"id": "1"}}],"precio":"10","formasPago":[{"cantidad": 1,"formaPago":{"id":"1"}}]}'
    @saleService.test str
  end

  def persist
    p = set_persist_model
    sale = Sale.new
    sale.fecha = Date.strptime(p['fecha'], '%y-%m-%d')
    sale.sale_details = Array.new
    p['productos'].to_h.each_with_index do |(k, v), i|
      detail = SaleDetail.new
      detail.cantidad = v['cantidad'];
      detail.fila = i
      detail.precio = v['precio']
      detail.product_id = v['product_id']
      sale.sale_details<<detail
    end

    sale.vfps = Array.new
    p['formasPago'].to_h.each_with_index do |(k, v), i|
      vfp = Vfp.new
      vfp.cantidad = v['cantidad']
      vfp.payment_form_id = v['id']
      sale.vfps << vfp
    end

    sale.client = Client.new id: p['client_id']
    @saleService.save_fromjson sale, include: [:sale_details, :vfps]
  end

  # POST /sales
  # POST /sales.json
  def create

    return
    @sale = Sale.save(sale_params, session[:JSESSIONID])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    params.require(:sale).permit(:fecha)
  end

  def set_persist_model
    params.require(:sale).permit(:fecha, :client_id, {:formasPago => [:id, :cantidad]}, {:productos => [:product_id, :cantidad, :precio]})
  end
end
