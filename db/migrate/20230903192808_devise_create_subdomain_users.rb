# frozen_string_literal: true

class DeviseCreateSubdomainUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomain_users, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :first_name
      t.string :last_name
      t.string :i_card_no_or_roll_no
      t.integer :branch
      t.integer :year
      t.string :github_url
      t.string :linked_in_url
      t.boolean :is_valid, default: false

      t.timestamps null: false
    end

    add_index :subdomain_users, :email,                unique: true
    add_index :subdomain_users, :reset_password_token, unique: true
    # add_index :subdomain_users, :confirmation_token,   unique: true
    # add_index :subdomain_users, :unlock_token,         unique: true
  end
end
