class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :email, :location, :role, presence: true
  validates :email, uniqueness: true
  validate :role_has_to_be_student_admin_or_company, :searching_is_present_in_students_and_companies

  has_many :job_posts, as: :company 
  has_many :job_applications, as: :student





	def name
		first_name + " " + last_name
	end

	scope :students, -> { where(role: "student") }
	scope :companies, -> { where(role: "company")}

	# def self.students
	# 	self.where(role: "student")
	# end

	# def self.companies
	# 	self.where(role: "company")
	# end

	private

	def role_has_to_be_student_admin_or_company
		if role != "student" && role != "admin" && role != "company"
			errors.add(:role, "must be student, admin or company")
		end
	end

	def searching_is_present_in_students_and_companies
		if role != "admin" && searching.nil?
			errors.add(:searching, "must include searching status")
		end
	end
end
