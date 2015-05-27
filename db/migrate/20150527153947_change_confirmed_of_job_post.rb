class ChangeConfirmedOfJobPost < ActiveRecord::Migration
  def change
    change_column :job_posts, :confirmed, :string, default: "unconfirmed"
  end
end
