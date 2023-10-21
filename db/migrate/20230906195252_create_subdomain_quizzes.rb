class CreateSubdomainQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomain_quizzes, id: :uuid do |t|
      t.string :title
      t.integer :total_questions
      t.time :duration
      t.integer :year
      t.integer :branch

      t.timestamps
    end
  end
end
