class AddConfirmedToJobPost < ActiveRecord::Migration
  def change
  	add_column :job_posts, :confirmed, :boolean, default: false, index: true
  end
end
