class AddColumnsToJobPost < ActiveRecord::Migration
  def change
  	change_table :job_posts do |t|
  		t.text :description
  		t.string :location
  		t.integer :salary
  		t.string :contract_type
  		t.string :position  		
  	end
  end
end
