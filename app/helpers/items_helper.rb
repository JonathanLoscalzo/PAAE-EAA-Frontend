module ItemsHelper
	

	def self.find(id, j_session_id)
		response = HTTParty.get "http://localhost:8080/web-module/items/#{id}", cookies: {"JSESSIONID": j_session_id}
		Item.new (JSON.parse(response.body))
	end

	def self.save(item_params, j_session_id)
		options = {
			cookies: {"JSESSIONID": j_session_id},
			body: item_params.to_json,
			headers: { 'Content-Type' => 'application/json'}
		}
		item = Item.new(item_params)
		if item.valid?
			response = HTTParty.post "http://localhost:8080/web-module/items", options
			unless response.code==201 
				item.errors.add(:item, 'no se pudo guardar, codigo de respuesta '+ response.code.to_s)
			end
		end
		
		item
	end

	def self.all(j_session_id)
		response = HTTParty.get "http://localhost:8080/web-module/items", cookies: {"JSESSIONID": j_session_id}
		items_params = JSON.parse(response.body)
		
		items_params.map do |elem|
			Item.new(elem)
		end
		
	end

	def self.destroy(id,j_session_id)
		response = HTTParty.delete "http://localhost:8080/web-module/items/#{id}", cookies: {"JSESSIONID": j_session_id}
	end
	
end
