class User < ActiveRecord::Base
	validates :first_name, :last_name, :email, :location, :role, presence: true
	validates :email, uniqueness: true
	validate :role_has_to_be_student_admin_or_company



	def role_has_to_be_student_admin_or_company
		if role != "student" && role != "admin" && role != "company"
			errors.add(:role, "must be student, admin or company")
		end
	end
end
