class CreatePaymentForms < ActiveRecord::Migration
  def change
    if (ActiveRecord::Base.connection.table_exists? 'payment_forms')
      drop_table :payment_forms
    end
    create_table :payment_forms do |t|
      t.index :id
      t.string :nombre
      t.boolean :permiteDarCambio

      t.timestamps null: false
    end
  end
end
