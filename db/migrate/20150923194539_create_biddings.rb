class CreateBiddings < ActiveRecord::Migration
  def change
    create_table :biddings do |t|
      t.integer :product_id
      t.integer :bidder_id

      t.timestamps null: false
    end
  end
end
