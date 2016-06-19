class LoginController < ApplicationController
	skip_before_action :require_login

	def show

	end

	def signin

		login_results = LoginService.login(login_params)

		if(login_results[:success])
			session[:JSESSIONID] = login_results[:jsessionid]
			redirect_to '/'
			puts session[:JSESSIONID]
		else
			redirect_to '/login'
		end
	end

	def login_params

      #no le des bola a los ultimos 3
      params.permit(:username, :password, :utf8, :authenticity_token, :commit)
    end
end
