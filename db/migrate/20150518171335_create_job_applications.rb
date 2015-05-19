class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.belongs_to :student, index: true
      t.belongs_to :job_posting, index: true


      t.timestamps null: false
    end
  end
end
