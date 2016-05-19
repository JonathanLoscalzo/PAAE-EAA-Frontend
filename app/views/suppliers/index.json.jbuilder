json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :name, :product_request_url
  json.url supplier_url(supplier, format: :json)
end
