class ChangeColumnToProduct < ActiveRecord::Migration
  def change
    change_column :products, :status, :integer, null: false, default: 0
  end
end
