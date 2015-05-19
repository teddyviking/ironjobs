class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.belongs_to :student, index: true
      t.string :student_type
      t.belongs_to :job_post, index: true


      t.timestamps null: false
    end
  end
end
