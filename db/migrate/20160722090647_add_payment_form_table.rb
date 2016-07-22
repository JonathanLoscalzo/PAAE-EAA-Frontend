class AddPaymentFormTable < ActiveRecord::Migration
  def change
    create_table :payment_forms do |t|
      t.index :id
      t.integer :nombre
      t.boolean :permiteDarCambio
    end
  end
end
