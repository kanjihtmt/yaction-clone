class AddCounterCacheToProduct < ActiveRecord::Migration
  def change
    add_column :products, :biddings_count, :integer, default: 0
  end
end
