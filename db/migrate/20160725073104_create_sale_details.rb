class CreateSaleDetails < ActiveRecord::Migration
  def change
    create_table :sale_details do |t|
      t.integer :fila
      t.float :precio
      t.integer :cantidad
      t.belongs_to :product, index:true
      t.belongs_to :sale, index:true

      t.timestamps null: false
    end

  end
end
