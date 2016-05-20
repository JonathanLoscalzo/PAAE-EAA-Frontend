class AddSupplierToProduct < ActiveRecord::Migration
  def change
  	add_reference :products, :supplier, index: true
    add_foreign_key :products, :suppliers
  end
end
