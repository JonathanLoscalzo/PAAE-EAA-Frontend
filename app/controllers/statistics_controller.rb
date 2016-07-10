class StatisticsController < ApplicationController
  def show

	products = ProductService.all_with_units(session[:JSESSIONID])
	chart_data = {
		:name 			=> [],
		:current_units 	=> [],
		:total_units 	=> []
	}
	products.each do |product |
		chart_data[:total_units] 	<< product["total_units"]
		chart_data[:current_units] 	<< product["current_units"]
		chart_data[:name] 			<< product["name"]
	end
  	@data = {
	  	labels: chart_data[:name],
	  	datasets: [
		    {
		        label: "Unidades totales",
		        backgroundColor: "rgba(220,220,220,0.8)",
		        borderColor: "rgba(220,220,220,1)",
		        data: chart_data[:total_units]
		    },
		    {
		        label: "Unidades actuales",
		        backgroundColor: "rgba(151,187,205,0.8)",
		        borderColor: "rgba(151,187,205,1)",
		        data: chart_data[:current_units]
		    }
	  	]
	}

  end
end
