class CreateVfps < ActiveRecord::Migration
  def change
    create_table :vfps do |t|
      t.float :cantidad, default: 0
      t.belongs_to :sale, index: true
      t.belongs_to :payment_form, index: true
      t.timestamps null: false
    end

    add_belongs_to :sales, :client, index: true
  end
end
