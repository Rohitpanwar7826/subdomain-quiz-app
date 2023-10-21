class AddColumnToQuizzes < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_quizzes, :is_published, :boolean, default: false
  end
end
