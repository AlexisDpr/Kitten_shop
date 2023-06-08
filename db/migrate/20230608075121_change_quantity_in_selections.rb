class ChangeQuantityInSelections < ActiveRecord::Migration[7.0]
  def change
    change_column  :selections, :quantity, :integer, default: 1
  end  
end
