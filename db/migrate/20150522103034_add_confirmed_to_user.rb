class AddConfirmedToUser < ActiveRecord::Migration
  def change
  	add_column :users, :confirmed, :boolean, default: true, index: true
  end
end
