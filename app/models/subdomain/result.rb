class Subdomain::Result < ApplicationRecord
  belongs_to :subdomain_quiz, class_name: 'Subdomain::Quiz'
  belongs_to :subdomain_user, class_name: 'Subdomain::User'
  belongs_to :subdomain_quiz_enrollment, class_name: 'Subdomain::QuizEnrollment'

  enum :pass_or_fail, { passed: 0, fail: 1 }
end
