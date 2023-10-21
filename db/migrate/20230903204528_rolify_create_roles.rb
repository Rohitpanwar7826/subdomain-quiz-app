class RolifyCreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table(:roles, id: :uuid) do |t|
      t.string :name
      t.references :resource, :polymorphic => true, type: :uuid

      t.timestamps
    end

    create_table(:subdomain_users_roles, :id => false) do |t|
      t.references :user, type: :uuid
      t.references :role, type: :uuid
    end
    
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:subdomain_users_roles, [ :user_id, :role_id ])
  end
end
