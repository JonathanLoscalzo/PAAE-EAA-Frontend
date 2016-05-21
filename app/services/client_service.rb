class ClientService
	@@clients_url = "http://localhost:8080/web-module/clients"


	def self.find(id, j_session_id)
		
		response = HTTParty.get @@clients_url + "/#{id}", cookies: {"JSESSIONID": j_session_id}
		Client.new (JSON.parse(response.body))
	end

	def self.save(client_params, j_session_id)
		options = {
			cookies: {"JSESSIONID": j_session_id},
			body: client_params.to_json,
			headers: { 'Content-Type' => 'application/json'}
		}
		client = Client.new(client_params)
		if client.valid?
			response = HTTParty.post @@clients_url, options
			unless response.code==201 
				client.errors.add(:client, 'no se pudo guardar. Codigo de respuesta: '+ response.code.to_s)
			end
		end
		client
	end

	def self.all(j_session_id)
		
		response = HTTParty.get  @@clients_url, cookies: {"JSESSIONID": j_session_id}
		client_params = JSON.parse(response.body)
		
		client_params.map do |elem|
			Client.new(elem)
		end
		
	end

	def self.destroy(client,j_session_id)
		response = HTTParty.delete @@clients_url+"/#{client.id}", cookies: {"JSESSIONID": j_session_id}
	end
end