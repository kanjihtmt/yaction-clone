class AddAboutmeToUser < ActiveRecord::Migration
  def change
    add_column :users, :aboutme, :string
  end
end
