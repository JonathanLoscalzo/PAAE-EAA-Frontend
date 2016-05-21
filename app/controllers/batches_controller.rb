class BatchesController < ApplicationController
  before_action :set_product
  before_action :set_batch, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:new]
  
  # GET products/1/batches
  def index
    @batches = @product.batches
  end

  # GET products/1/batches/1
  def show
  end

  # GET products/1/batches/new
  def new
    @batch = @product.batches.build
  end

  # GET products/1/batches/1/edit
  def edit
  end

  # POST products/1/batches
  def create
   
   
    @batch = BatchService.save(batch_params, session[:JSESSIONID])
    respond_to do |format|
      if @batch.errors.empty?
        format.html {  redirect_to product_path(@product), notice: 'Lote creado exitosamente' }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT products/1/batches/1
  def update
    if @batch.update_attributes(batch_params)
      redirect_to([@batch.product, @batch], notice: 'Batch was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE products/1/batches/1
  def destroy
    @batch.destroy

    redirect_to product_batches_url(@product)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product

      @product = ProductService.find(params[:product_id], session[:JSESSIONID])
    end

    def set_batch
      @batch = @product.batches.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def batch_params
      params.require(:batch).permit(:detail, :expiration_date, :entry_date, :product_id, :total_units)
    end
end
