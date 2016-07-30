class LoginController < ApplicationController
	skip_before_action :require_login

	def show

	end

	def signin

		login_results = LoginService.login(login_params)

		if(login_results[:success])
			session[:JSESSIONID] 	= login_results[:jsessionid]
			session[:menus] 			= login_results[:menus]
			session[:client_id] 	= login_results[:client_id]
			redirect_to '/'
		else
			redirect_to '/login'
		end
	end

	private
	
	def login_params

      #no le des bola a los ultimos 3
      params.permit(:username, :password, :utf8, :authenticity_token, :commit)
    end
end
