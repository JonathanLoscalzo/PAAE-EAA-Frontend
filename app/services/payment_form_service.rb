class PaymentFormService < Service
  def url 
    @url + "/FormasPago"
  end

  def someClass
    PaymentForm
  end
end