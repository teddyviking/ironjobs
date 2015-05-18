class AddDefaultToSearchingAndRole < ActiveRecord::Migration
  def change
    change_column_default :users, :role, "company"
    change_column_default :users, :searching, false
  end
end
