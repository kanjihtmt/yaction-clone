class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :image2, :string
    add_column :products, :image3, :string
  end
end
