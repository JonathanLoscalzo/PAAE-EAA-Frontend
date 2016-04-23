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
		response = HTTParty.post "http://localhost:8080/web-module/items", options
		response.code==201? Item.new(item_params) : nil
	end
	
end
