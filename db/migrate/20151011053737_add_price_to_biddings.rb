class AddPriceToBiddings < ActiveRecord::Migration
  def change
    add_column :biddings, :price, :integer
  end
end
