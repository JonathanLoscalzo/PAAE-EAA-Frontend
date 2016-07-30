class SaleService < Service

  def url
    @url + "/Venta"
  end

  def someClass
    Sale
  end

  def possibleError
    :Sale
  end


  def all_client_sales(client_id)
    client_sales_url = @url + "/Venta/client/#{client_id}"
    response = HTTParty.get client_sales_url, cookies: {"JSESSIONID": @jssession}
    if response.code ==200
      return JSON.parse(response.body).as_json
    end
    [].as_json
  end

end