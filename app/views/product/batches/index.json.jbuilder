json.array!(@product_batches) do |product_batch|
  json.extract! product_batch, :id, :detail, :expiration_date, :entry_date, :product_id
  json.url product_batch_url(product_batch, format: :json)
end
