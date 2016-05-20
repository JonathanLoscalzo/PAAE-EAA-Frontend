class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:new]

  # GET /products
  # GET /products.json
  def index
    @products = ProductsHelper.all(session[:JSESSIONID])
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @batches = BatchesHelper.all(@product, session[:JSESSIONID])
  end

  # GET /products/new
  def new
    @product = Product.new
    @suppliers = SuppliersHelper.all(session[:JSESSIONID])

  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    
    @product = ProductsHelper.save(product_params, session[:JSESSIONID])
    respond_to do |format|
      if @product.errors.empty?
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    ProductsHelper.destroy(params[:id], session[:JSESSIONID])
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = ProductsHelper.find(params[:id], session[:JSESSIONID])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      # , :batch_id --- acordarse de permitir en el futuro el batch_id
      params.require(:product).permit(:name, :minimum, :amount, :supplier_id)
    end
end
