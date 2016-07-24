class PaymentFormService < Service
  def url 
    @url + "/FormasPago"
  end

  def someClass
    PaymentForm
  end

  def possibleError
    :payment_form
  end
end