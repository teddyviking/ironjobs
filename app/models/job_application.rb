class JobApplication < ActiveRecord::Base
  belongs_to :student, -> { students }, class_name: "User", foreign_key: :student_id
  belongs_to :job_post
  
  validates :job_post_id, :student_id, presence: true
  validates_uniqueness_of :job_post_id, :scope => :student_id
  validate :user_is_student



  def user_is_student
    errors.add(:student_type, "must be a student to create an application") if self.student == nil
  end
end
