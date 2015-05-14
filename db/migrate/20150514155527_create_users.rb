class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :location
      t.string :name
      t.string :last_name
      t.string :url
      t.string :facebook
      t.string :github 
      t.string :twitter
      t.string :linkedin
      t.text :description
      t.integer :phone
      t.boolean :searching
      t.string :email

      t.timestamps null: false
    end
  end
end
