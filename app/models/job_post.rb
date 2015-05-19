class JobPost < ActiveRecord::Base
	belongs_to :company, class_name: "User", foreign_key: :company_id

	validate :user_is_company



	def user_is_company
		errors.add(:company_type, "must be a company to create a Job Post") if self.company.role != "company"
	end
end
