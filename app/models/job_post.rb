class JobPost < ActiveRecord::Base

	validates :description, :salary, :contract_type, :position, presence: true
	validate :user_is_company


	belongs_to :company, -> { companies }, class_name: "User", foreign_key: :company_id
	has_many :job_applications
	has_many :applicants, through: :job_applications, source: "student"

	acts_as_taggable



	def user_is_company
		errors.add(:company_type, "must be a company to create a Job Post") if self.company == nil
	end
end
