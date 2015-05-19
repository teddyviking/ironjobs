class JobPost < ActiveRecord::Base
	belongs_to :company, -> { companies }, class_name: "User", foreign_key: :company_id
	has_many :job_applications
	validates :description, :salary, :contract_type, :position, presence: true
	validate :user_is_company



	def user_is_company
		errors.add(:company_type, "must be a company to create a Job Post") if self.company == nil
	end
end
