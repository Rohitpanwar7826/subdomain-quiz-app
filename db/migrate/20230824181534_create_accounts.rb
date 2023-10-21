class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :subdomain
      t.string :title
      t.string :default_locale
      t.string :target_id

      t.timestamps
    end
  end
end
