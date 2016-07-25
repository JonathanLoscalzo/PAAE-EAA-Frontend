class AddUserToSales < ActiveRecord::Migration
  def change
    add_belongs_to :sales, :user, index: true
  end
end
