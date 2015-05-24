class RemoveFacebookFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :facebook
  end
end
