class CreateSubdomainReports < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomain_reports, id: :uuid do |t|
      t.references :subdomain_quiz, null: false, foreign_key: true, type: :uuid
      t.references :subdomain_question, null: false, foreign_key: true, type: :uuid
      t.references :subdomain_user, null: false, foreign_key: true, type: :uuid
      t.string :weight
      t.json :result
      t.boolean :is_correct

      t.timestamps
    end
  end
end
