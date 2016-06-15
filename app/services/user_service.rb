class UserService
	@@users_url = "http://localhost:8080/web-module/users"


	def self.find(id, j_session_id)
		
		response = HTTParty.get @@users_url + "/#{id}", cookies: {"JSESSIONID": j_session_id}
		User.new (JSON.parse(response.body))
	end

	def self.save(user_params, j_session_id)
		options = {
			cookies: {"JSESSIONID": j_session_id},
			body: user_params.to_json,
			headers: { 'Content-Type' => 'application/json'}
		}
		user = User.new(user_params)


		if user.valid?
			response = HTTParty.post @@users_url, options
			unless response.code==201 
				user.errors.add(:user, 'no se pudo guardar. Codigo de respuesta: '+ response.code.to_s)
				asd
			end
		end
		user
	end

	def self.all(j_session_id)
		
		response = HTTParty.get  @@users_url, cookies: {"JSESSIONID": j_session_id}
		user_params = JSON.parse(response.body)
		
		user_params.map do |elem|
			User.new(elem)
		end
		
	end

	def self.destroy(id,j_session_id)
		response = HTTParty.delete @@users_url+"/#{id}", cookies: {"JSESSIONID": j_session_id}
	end
end