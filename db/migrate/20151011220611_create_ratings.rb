class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :seller_id
      t.integer :bidder_id
      t.integer :value

      t.timestamps null: false
    end
  end
end
