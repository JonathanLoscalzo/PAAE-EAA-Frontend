class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  private
  def require_login
  	base_url = "http://localhost:8080/web-module"
  	options = {
		cookies: {"JSESSIONID": session[:JSESSIONID]},
		headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
	}
	result = HTTParty.get base_url, options
    if (result.code == 401) #unauthorized
    	options[:body] = "username=admin&password=admin"
    	options.delete(:cookies)

    	response = HTTParty.post base_url+"/login", options
    	#spliteamos la vida para quedarnos unicamente con el numero.
    	#JSESSIONID=136610EF8907DCE8A284D2C1FECF144A; Path=/web-module 
    	session[:JSESSIONID] = response.headers["set-cookie"].split(';').first.split("=").last
    end
  end
end
