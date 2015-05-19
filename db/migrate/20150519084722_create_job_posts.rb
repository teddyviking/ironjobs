class CreateJobPosts < ActiveRecord::Migration
  def change
    create_table :job_posts do |t|
      t.belongs_to :company, index: true
      t.string :company_type
      
      t.timestamps null: false
    end
  end
end
