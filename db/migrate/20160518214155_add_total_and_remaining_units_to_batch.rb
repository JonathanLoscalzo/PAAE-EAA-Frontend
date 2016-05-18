class AddTotalAndRemainingUnitsToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :remaining_units, :integer
    add_column :batches, :total_units, :integer
  end
end
