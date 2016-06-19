class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  #before_action :require_login
  before_action :require_auto_login
 


  private
 
  def require_login
    redirect_to "/login" unless is_authorized 
  end


  def require_auto_login
    
    if (! is_authorized)
      options = login_options
      options.delete(:cookies)

      options[:body] = "username=admin&password=admin"

      response = HTTParty.post base_url+"/login", options

      #spliteamos la vida para quedarnos unicamente con el numero.
      #JSESSIONID=136610EF8907DCE8A284D2C1FECF144A; Path=/web-module 
      session[:JSESSIONID] = response.headers["set-cookie"].split(';').first.split("=").last

    end

  end

  ############################################################

  def base_url
    "http://localhost:8080/web-module"
  end

  def login_options
    {
      cookies: {"JSESSIONID": session[:JSESSIONID]},
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded'}
    }
  end

  def is_authorized
      result = HTTParty.get base_url, login_options
      result.code!=401
  end

end
