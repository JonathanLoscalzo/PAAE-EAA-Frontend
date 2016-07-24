json.array!(@payment_forms) do |payment_form|
  json.extract! payment_form, :id, :nombre, :permiteDarCambio
  json.url payment_form_url(payment_form, format: :json)
end
