class Subdomain::Report < ApplicationRecord
  belongs_to :subdomain_quiz, class_name: 'Subdomain::Quiz'
  belongs_to :subdomain_question, class_name: 'Subdomain::Question'
  belongs_to :subdomain_user, class_name: 'Subdomain::User'

end
