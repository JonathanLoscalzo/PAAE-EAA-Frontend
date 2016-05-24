class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    
  end


  def create_client
  	create_and_save_client
  	redirect_to "/"
  end

  def create_supplier
  	create_and_save_supplier
  	redirect_to "/"
  end

  def create_product
    create_and_save_product
    redirect_to "/"
  end

  def create_batch
    create_and_save_batch
    redirect_to "/"
  end

  def create_all
    create_and_save_client
    create_and_save_supplier
    create_and_save_product
    create_and_save_batch
    redirect_to "/"
  end




  private

  def create_and_save_client
    client={
      :first_name => "juan",
      :last_name =>"perez",
      :dni =>"1234"
    }
    ClientService.save(client, session[:JSESSIONID])
  end

  def create_and_save_supplier
    supplier={
      :name => "proveedor",
      :product_request_url => "proveedor@gmail.com"
    }
    SupplierService.save(supplier, session[:JSESSIONID])
  end

  def create_and_save_product
    product={
      :name => "pepsi",
      :minimum =>"123",
      :supplier_id =>"0"
    }
    ProductService.save(product, session[:JSESSIONID])
  end

  def create_and_save_batch
    batch={
      :detail => "lote 1",
      :expiration_date =>"2016-01-30",
      :entry_date =>"2016-01-30",
      :total_units => "20",
      :product_id => "0"
    }

    BatchService.save(batch, session[:JSESSIONID])
  end

end