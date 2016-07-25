class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.datetime :fecha
      t.integer :nro
      t.timestamps null: false
    end

  end
end
