class AddUserReferencesToAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :admin_user, null: false, foreign_key: true, type: :uuid
  end
end
