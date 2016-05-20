module ProductsHelper

	@@products_url = "http://localhost:8080/web-module/products"


	def self.find(id, j_session_id)
		
		response = HTTParty.get @@products_url + "/#{id}", cookies: {"JSESSIONID": j_session_id}

		product = Product.new (JSON.parse(response.body))

		supplier = SuppliersHelper.find(product.supplier_id, j_session_id)
		product.supplier = supplier
		product
	end

	def self.save(product_params, j_session_id)
		options = {
			cookies: {"JSESSIONID": j_session_id},
			body: product_params.to_json,
			headers: { 'Content-Type' => 'application/json'}
		}
		product = Product.new(product_params)
		if product.valid?
			response = HTTParty.post @@products_url, options
			unless response.code==201 
				product.errors.add(:product, 'no se pudo guardar. Codigo de respuesta: '+ response.code.to_s)
			end
		end
		product
	end

	def self.all(j_session_id)
		
		response = HTTParty.get  @@products_url, cookies: {"JSESSIONID": j_session_id}
		product_params = JSON.parse(response.body)
		
		product_params.map do |elem|
			Product.new(elem)
		end
		
	end

	def self.destroy(id,j_session_id)
		response = HTTParty.delete @@products_url+"/#{id}", cookies: {"JSESSIONID": j_session_id}
	end


end
