class PaymentFormsService
  @@url ="http://localhost:8080/web-module/FormasPago"
  def self.all(j_session_id)
		response = HTTParty.get  @@url, cookies: {"JSESSIONID": j_session_id}
		payment_form_params = JSON.parse(response.body)
		payment_form_params.map do |elem|
			PaymentForm.new(elem)
		end
	end

	def self.find(id, j_session_id)
		
	end

	def self.save(product_params, j_session_id)
		
	end

	def self.destroy(id,j_session_id)
	end
end