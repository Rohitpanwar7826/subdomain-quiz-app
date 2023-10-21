class Subdomain::QuizEnrollment < ApplicationRecord
  belongs_to :user, class_name: 'Subdomain::User', foreign_key: 'subdomain_user_id'
  belongs_to :quiz, class_name: 'Subdomain::Quiz', foreign_key: 'subdomain_quiz_id'

  enum :status, { to_do: 0, in_progress: 1, not_token: 2, complete: 3 }

  scope :by_quiz_id, -> (quiz_id) { where(subdomain_quiz_id: quiz_id) }

  has_one :result, class_name: "Subdomain::Result", foreign_key: "subdomain_quiz_enrollment_id"
end
# 3:30pm
#   3:25pm
#   count_timer
#   u1 -> user_1

# 3:45pm
#   count_timer
#   u1 -> user_1