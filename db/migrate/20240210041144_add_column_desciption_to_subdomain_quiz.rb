class AddColumnDesciptionToSubdomainQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_quizzes, :description, :text
  end
end
