class AddQuantityToSelections < ActiveRecord::Migration[7.0]
  def change
    add_column :selections, :quantity, :integer
  end
end
