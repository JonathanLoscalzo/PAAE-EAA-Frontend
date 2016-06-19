class LoginService
	@@login_url = "http://localhost:8080/web-module/login"


	def self.login(login_params)
		
		options = {		 
		  headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
		}
		
		options[:body] = "username=#{login_params[:username]}&password=#{login_params[:password]}"
		
		response = HTTParty.post @@login_url, options
		#spliteamos la vida para quedarnos unicamente con el numero.
    	#JSESSIONID=136610EF8907DCE8A284D2C1FECF144A; Path=/web-module
    	if(response.code == 200)
    		jsessionid = response.headers["set-cookie"].split(';').first.split("=").last
    		login_results = { success: true, jsessionid: jsessionid}
    	else
    		login_results = { success: false}
    	end
	end

end