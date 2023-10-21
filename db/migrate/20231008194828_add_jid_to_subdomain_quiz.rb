class AddJidToSubdomainQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_quizzes, :jid, :string
  end
end
