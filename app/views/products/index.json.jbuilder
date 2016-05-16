json.array!(@products) do |product|
  json.extract! product, :id, :name, :minimum, :amount, :batch_id
  json.url product_url(product, format: :json)
end
