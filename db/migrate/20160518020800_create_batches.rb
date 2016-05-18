class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :detail
      t.date :expiration_date
      t.date :entry_date
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
