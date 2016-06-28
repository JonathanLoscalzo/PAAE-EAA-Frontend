class LoginService
	@@login_url = "http://localhost:8080/web-module"


	def self.login(login_params)
		
		options = login_options
		options[:body] = "username=#{login_params[:username]}&password=#{login_params[:password]}"
		response = HTTParty.post @@login_url+"/login", options

		
	  	if(response.code == 200)
	  		# spliteamos la vida, ej:
	  		# credenciales=ADMIN, JSESSIONID=136610EF8907DCE8A284D2C1FECF144A; Path=/web-module
	  		cookies = response.headers["set-cookie"].split(';').first.split(",")

	  		role = cookies.first.split("=").last 
	  		jsessionid = cookies.last.split("=").last
	  		
	  		login_results = { success: true, jsessionid: jsessionid}
	  	else
	  		login_results = { success: false}
	  	end
	end


	def self.is_authenticated(jsessionid)
		options = login_options
		options[:cookies] = { "JSESSIONID" => jsessionid }

		result = HTTParty.get @@login_url, options
      	result.code!=401 && result.code!=403  #unauthorized y forbidden
	end

	private 

    def self.login_options
    	{
      		headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
    	}
  	end
end