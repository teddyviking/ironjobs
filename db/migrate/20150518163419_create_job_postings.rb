class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.text :description
      t.string :title
      t.string :position
      t.string :contract_type
      t.string :category
      t.integer :salary
      t.string :location
      t.date :deadline


      t.integer :company_id
      t.string :company_type

      t.timestamps null: false
    end
  end
end
