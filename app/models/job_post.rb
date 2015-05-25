class JobPost < ActiveRecord::Base

	validates :description, :salary, :contract_type, :position, presence: true
	validate :user_is_company


	belongs_to :company, -> { companies }, class_name: "User", foreign_key: :company_id
	has_many :job_applications
	has_many :applicants, through: :job_applications, source: "student"

	acts_as_taggable

	after_create :send_admin_mail



	scope :confirmed, -> { where(confirmed: true) }


	def user_is_company
		errors.add(:company_type, "must be a company to create a Job Post") if self.company == nil
	end

	private

	def send_admin_mail
		AdminMailer.send_new_job_post_notification(self).deliver_now
	end
end
