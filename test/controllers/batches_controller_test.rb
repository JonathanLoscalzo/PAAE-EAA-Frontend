require 'test_helper'

class BatchesControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @batch = batches(:one)
  end

  test "should get index" do
    get :index, params: { product_id: @product }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { product_id: @product }
    assert_response :success
  end

  test "should create batch" do
    assert_difference('Batch.count') do
      post :create, params: { product_id: @product, batch: @batch.attributes }
    end

    assert_redirected_to product_batch_path(@product, Batch.last)
  end

  test "should show batch" do
    get :show, params: { product_id: @product, id: @batch }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { product_id: @product, id: @batch }
    assert_response :success
  end

  test "should update batch" do
    put :update, params: { product_id: @product, id: @batch, batch: @batch.attributes }
    assert_redirected_to product_batch_path(@product, Batch.last)
  end

  test "should destroy batch" do
    assert_difference('Batch.count', -1) do
      delete :destroy, params: { product_id: @product, id: @batch }
    end

    assert_redirected_to product_batches_path(@product)
  end
end
