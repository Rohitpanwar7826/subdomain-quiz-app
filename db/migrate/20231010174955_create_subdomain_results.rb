class CreateSubdomainResults < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomain_results, id: :uuid do |t|
      t.references :subdomain_quiz, null: false, foreign_key: true, type: :uuid
      t.references :subdomain_user, null: false, foreign_key: true, type: :uuid
      t.references :subdomain_quiz_enrollment, null: false, foreign_key: true, type: :uuid
      t.integer :total
      t.integer :out_of
      t.integer :pass_or_fail

      t.timestamps
    end
  end
end
