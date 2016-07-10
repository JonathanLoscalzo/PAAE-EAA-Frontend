class AlarmsController < ApplicationController
  def show
  	@products = ProductService.close_to_run_out(session[:JSESSIONID])

  end
end
