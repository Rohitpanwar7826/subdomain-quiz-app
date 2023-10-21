class AddColumnToSubdomainQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_quizzes, :status, :integer, default: 0
  end
end
