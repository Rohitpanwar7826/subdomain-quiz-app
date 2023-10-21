class Subdomain::Quiz < ApplicationRecord
  belongs_to :subdomain_user, class_name: 'Subdomain::User'

  enum :year, { '1st': 0, '2nd': 1, '3rd': 2, '4th': 3 }

  enum :branch, { 'IT': 0, 'CS': 1, 'ME': 2, 'EC': 3 }

  enum :status, { soon: 0, complete: 1, cancelled: 2 }

  scope :is_publisheds, -> { where(is_published: true)}

  validates :branch, :year, presence: true

  validates :title, presence: true, uniqueness: true, length: {maximum: 50}
  
  validates :duration, numericality: { greater_than_or_equal: 10, less_than_or_equal_to: 60 }

  validates :total_questions, numericality: { greater_than: 3, less_than_or_equal_to: 25 }

  has_many :questions, class_name: 'Subdomain::Question', foreign_key: "subdomain_quiz_id", dependent: :destroy

  has_many :quiz_enrollments, foreign_key: 'subdomain_quiz_id', dependent: :destroy

  has_many :enrolled_users, through: :quiz_enrollments, source: :user

  accepts_nested_attributes_for :questions

  has_many :reports, class_name: "Subdomain::Report", foreign_key: "subdomain_quiz_id", dependent: :destroy

  has_many :results, class_name: "Subdomain::Result", foreign_key: "subdomain_quiz_id", dependent: :destroy

  def reports_by_user(user_id)
    reports.where(subdomain_user_id: user_id)
  end

  def base_line_assessment(user_id)
    quiz_enrollments.find_by(subdomain_user_id: user_id)
    .yield_self { |quiz_enrollment| quiz_enrollment.in_progress! }
  end

  def is_schedule_job?
    self.jid.present?
  end
end
