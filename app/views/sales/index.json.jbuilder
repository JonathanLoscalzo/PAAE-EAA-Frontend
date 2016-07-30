json.array!(@sales) do |sale|
  json.extract! sale, 'id'
end
