class SupplierService
	@@suppliers_url = "http://localhost:8080/web-module/suppliers"


	def self.find(id, j_session_id)
		
		response = HTTParty.get @@suppliers_url + "/#{id}", cookies: {"JSESSIONID": j_session_id}
		Supplier.new (JSON.parse(response.body))
	end

	def self.save(supplier_params, j_session_id)
		options = {
			cookies: {"JSESSIONID": j_session_id},
			body: supplier_params.to_json,
			headers: { 'Content-Type' => 'application/json'}
		}
		supplier = Supplier.new(supplier_params)
		if supplier.valid?
			response = HTTParty.post @@suppliers_url, options			
			unless response.code==201 
				supplier.errors.add(:supplier, 'no se pudo guardar. Codigo de respuesta: '+ response.code.to_s)
			end
		end
		supplier
	end

	def self.all(j_session_id)
		
		response = HTTParty.get  @@suppliers_url, cookies: {"JSESSIONID": j_session_id}
		supplier_params = JSON.parse(response.body)
		
		supplier_params.map do |elem|
			Supplier.new(elem)
		end
		
	end

	def self.destroy(id,j_session_id)
		response = HTTParty.delete @@suppliers_url+"/#{id}", cookies: {"JSESSIONID": j_session_id}
	end
end