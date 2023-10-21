class Subdomain::User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  enum :year, { '1st': 0, '2nd': 1, '3rd': 2, '4th': 3 }

  enum :branch, { 'IT': 0, 'CS': 1, 'ME': 2, 'EC': 3 }

  scope :teachers, -> { self.joins(:roles).where(roles: { name: 'teacher' }) }
  scope :students, -> { self.joins(:roles).where(roles: { name: 'student' }) }

  has_many :quizzes, foreign_key: 'subdomain_user_id', dependent: :destroy

  has_many :quiz_enrollments, foreign_key: 'subdomain_user_id',  class_name: 'Subdomain::QuizEnrollment'

  has_many :enrolled_quizzes, through: :quiz_enrollments,  class_name: 'Subdomain::Quiz', source: :subdomain_quiz

  has_many :reports, class_name: "Subdomain::Report", foreign_key: "subdomain_user_id"

  has_many :results, class_name: "Subdomain::Result", foreign_key: "subdomain_user_id"

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
