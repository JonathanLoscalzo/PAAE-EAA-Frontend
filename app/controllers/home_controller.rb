class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    
  end

  def create_user_and_client
    create_and_save_user
    create_and_save_client
    redirect_to "/"
    
  end

  def create_user
    create_and_save_user
    redirect_to "/"
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
    create_and_save_payment_form
    redirect_to "/"
  end



  def consume_batch_units
    BatchService.consume_units(0,0, 8, session[:JSESSIONID])
    puts "ASDALSKDALSDKJASLDKJASDLKAJSDALSDKJASLDJKASLDKAJ"
    redirect_to "/"

  end


  private

  def create_and_save_client
    client={
      :first_name => "juan",
      :last_name =>"perez",
      :dni =>"1234",
      :user_id => "0"
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
      :minimum =>"5",
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

  def create_and_save_user
    user= {
      :username => "admin",
      :password => "admin",
      :role => "ROLE_CLIENT"
    }
    UserService.save(user, session[:JSESSIONID])
  end

  def create_and_save_payment_form
    payment_form = {
      :nombre => "mastercard",
      :permiteDarCambio => true
    }
    service = PaymentFormService.new session[:JSESSIONID]
    service.save(payment_form)
  end

end
