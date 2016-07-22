require 'test_helper'

class PaymentFormsControllerTest < ActionController::TestCase
  setup do
    @payment_form = payment_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_form" do
    assert_difference('PaymentForm.count') do
      post :create, payment_form: { id: @payment_form.id, nombre: @payment_form.nombre, permiteDarCambio: @payment_form.permiteDarCambio }
    end

    assert_redirected_to payment_form_path(assigns(:payment_form))
  end

  test "should show payment_form" do
    get :show, id: @payment_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_form
    assert_response :success
  end

  test "should update payment_form" do
    patch :update, id: @payment_form, payment_form: { id: @payment_form.id, nombre: @payment_form.nombre, permiteDarCambio: @payment_form.permiteDarCambio }
    assert_redirected_to payment_form_path(assigns(:payment_form))
  end

  test "should destroy payment_form" do
    assert_difference('PaymentForm.count', -1) do
      delete :destroy, id: @payment_form
    end

    assert_redirected_to payment_forms_path
  end
end
