class ChangeConfirmedFromUser < ActiveRecord::Migration
  def change
    change_column :users, :confirmed, :string, default: "confirmed"
  end
end
