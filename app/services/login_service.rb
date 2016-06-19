class LoginService
	@@login_url = "http://localhost:8080/web-module/login"


	def self.login(login_params)
		
		options = {		 
		  headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
		}
		
		options[:body] = "username=admin&password=admin"
		

		response = HTTParty.post @@login_url, options
		#spliteamos la vida para quedarnos unicamente con el numero.
    	#JSESSIONID=136610EF8907DCE8A284D2C1FECF144A; Path=/web-module 
    	jsessionid = response.headers["set-cookie"].split(';').first.split("=").last

    	login_results = { success: true, jsessionid: jsessionid}
	end

end