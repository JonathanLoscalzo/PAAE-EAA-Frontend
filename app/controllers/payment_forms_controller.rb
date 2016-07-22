class PaymentFormsController < ApplicationController
  before_action :set_payment_form, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:new]

  def index
    @payment_forms = PaymentFormsService.all(session[:JSESSIONID])
  end

  def show
  end

  def create
    @payment_form = PaymentFormsService.save(payment_form_params, session[:JSESSIONID])

    respond_to do |format|
      if @payment_form.errors.empty?
        format.html { redirect_to @payment_form, notice: 'FP creado exitosamente.' }
        format.json { render :show, status: :created, location: @payment_form }
      else
        format.html { render :new }
        format.json { render json: @payment_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_form
      @supplier = PaymentFormsService.find(params[:id], session[:JSESSIONID])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_form_params
      params.require(:payment_form).permit(:nombre, :permiteDarCambio)
    end
end