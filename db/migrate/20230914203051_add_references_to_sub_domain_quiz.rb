class AddReferencesToSubDomainQuiz < ActiveRecord::Migration[7.0]
  def change
    add_reference :subdomain_quizzes, :subdomain_user, null: false, foreign_key: true, type: :uuid
  end
end
