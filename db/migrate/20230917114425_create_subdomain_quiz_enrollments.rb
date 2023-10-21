class CreateSubdomainQuizEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomain_quiz_enrollments, id: :uuid do |t|
      t.references :subdomain_user, null: false, foreign_key: true, type: :uuid
      t.references :subdomain_quiz, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
