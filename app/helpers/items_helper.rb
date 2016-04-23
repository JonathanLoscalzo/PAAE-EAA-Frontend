module ItemsHelper
	

	def self.find(id, j_session_id)
		response = HTTParty.get "http://localhost:8080/web-module/items/#{id}", cookies: {"JSESSIONID": j_session_id}
		Item.new (JSON.parse(response.body))
	end
	
end
