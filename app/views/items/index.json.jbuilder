json.array!(@items) do |item|
  json.extract! item, :id, :name, :amount, :price
  json.url item_url(item, format: :json)
end
