class IntegrationTestsController < ApplicationController
  def show

  	@add_supplier_test = true;
  		test_add_supplier
  	@retrieve_supplier_test = true;
  		test_retrieve_supplier

  	@add_client_test = true;
  		test_add_client
  	@retrieve_client_test = true;
  		test_retrieve_client

  	@add_user_test = true;
  		test_add_user
  	@retrieve_user_test = true;
  		test_retrieve_user
  end

	private
######################################################################

  def test_add_supplier
  	begin
  		supplier = create_and_save_supplier
  		raise StandardError unless supplier.errors.empty?

  	rescue StandardError
  		@add_supplier_test = false;
  	end
  end

  def test_retrieve_supplier
  	begin
  		supplier = SupplierService.find(0, session[:JSESSIONID])
  		raise StandardError unless !supplier.nil? && supplier.name == "proveedor"

  	rescue StandardError
  		@retrieve_supplier_test = false;
  	end
  end

	def create_and_save_supplier
    supplier={
      :name => "proveedor",
      :product_request_url => "proveedor@gmail.com"
    }
    SupplierService.save(supplier, session[:JSESSIONID])
  end

######################################################################

	def test_add_client
		begin
  		client = create_and_save_client
  		raise StandardError unless client.errors.empty?

  	rescue StandardError
  		@add_client_test = false;
  	end
	end

  def create_and_save_client
    client={
      :first_name => "juan",
      :last_name =>"perez",
      :dni =>"1234"
    }
    ClientService.save(client, session[:JSESSIONID])
  end

  def test_retrieve_client
  	begin
  		client = ClientService.find(0, session[:JSESSIONID])
  		raise StandardError unless !client.nil? && client.first_name == "juan"

  	rescue StandardError
  		@retrieve_supplier_test = false;
  	end
  end
######################################################################
	


	def test_add_user
		begin
  		user = create_and_save_user
  		raise StandardError unless user.errors.empty?

  	rescue StandardError
  		@add_user_test = false;
  	end
	end

	def test_retrieve_user
  	begin
  		user = UserService.find(0, session[:JSESSIONID])
  		raise StandardError unless !user.nil? && user.username == "admin"

  	rescue StandardError
  		@retrieve_user_test = false;
  	end
  end

  def create_and_save_user
    user = {
      :username => "admin",
      :password => "admin",
      :role 		=> "ROLE_ADMIN"
    }
    UserService.save(user, session[:JSESSIONID])
  end


######################################################################

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


end
