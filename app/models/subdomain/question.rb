class Subdomain::Question < ApplicationRecord
  before_create :set_correct_answer

  belongs_to :subdomain_quiz, class_name: 'Subdomain::Quiz'

  validates :question, presence: true
  validates :options, presence: true
  validates :correct, presence: true


  has_many :reports, class_name: "Subdomain::Report", foreign_key: "subdomain_question_id", dependent: :destroy

  def set_correct_answer
    self.correct = options.with_indifferent_access[self.correct.downcase]
  end
end
