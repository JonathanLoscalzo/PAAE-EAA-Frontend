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

end