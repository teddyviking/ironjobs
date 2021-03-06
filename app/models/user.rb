class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :add_pending_confirmation, if: :is_a_company?

  validates :first_name, :last_name, :email, :location, :role, :confirmed, presence: true
  validates :role, inclusion: { in: %w(student admin company) }
  validates :confirmed, inclusion: { in: %w(unconfirmed confirmed denied) }
  validates :email, uniqueness: true
  validate  :searching_is_present_in_students_and_companies
  validate :company_validations, if: :is_a_company? 

  has_many :job_posts, as: :company 
  has_many :job_applications, as: :student
  has_many :applied_job_posts, through: :job_applications, source: 'job_post'

  acts_as_taggable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "default-profile-photo.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  scope :students, -> { where(role: "student") }
  scope :companies, -> { where(role: "company")}
  scope :confirmed_companies, -> { companies.where(confirmed: "confirmed")}

  after_create :send_admin_mail, if: :is_a_company?


  def name
    first_name + " " + last_name
  end

  def confirm_company
    self.update(confirmed: "confirmed")
    AdminMailer.send_company_activation(self).deliver_now
  end

  def deny_company
    self.update(confirmed: "denied")
  end

  def self.tagged_search(tags, role)
    if role == "student"
      search_student_with_tags(tags)
    elsif role == "company"
      search_company_with_tags(tags)
    end

  end

  private


  def searching_is_present_in_students_and_companies
    if role != "admin" && searching.nil?
      errors.add(:searching, "must include searching status")
    end
  end

  def add_pending_confirmation
    self.confirmed = "unconfirmed" if self.new_record?
    self
  end

  def is_a_company?
    self.role == "company"
  end

  def company_validations
    if  situation.nil?
      errors.add(:situation, "must include situation of the company")
    elsif company_name.nil?
      errors.add(:company_name, "must include company name")
    end
  end

  def send_admin_mail
      AdminMailer.send_new_company_notification(self).deliver_now
  end

  def self.search_student_with_tags(tags)
    return User.students if tags == ""
    students = User.students.tagged_with(tags)
  end

  def self.search_company_with_tags(tags)
    return User.confirmed_companies if tags == ""
    companies = User.confirmed_companies.tagged_with(tags)
  end
end
