class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :minimum
      t.integer :amount
      t.references :batch, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
