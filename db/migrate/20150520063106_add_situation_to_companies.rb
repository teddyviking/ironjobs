class AddSituationToCompanies < ActiveRecord::Migration
  def change
    add_column :users, :situation, :string
    add_column :users, :company_name, :string
  end
end
