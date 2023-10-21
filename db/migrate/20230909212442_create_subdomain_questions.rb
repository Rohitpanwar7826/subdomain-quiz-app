class CreateSubdomainQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomain_questions, id: :uuid do |t|
      t.text :question
      t.json :options
      t.string :correct
      t.references :subdomain_quiz, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
