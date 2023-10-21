class ChangePgcryptoExtensionSchema < ActiveRecord::Migration[7.0]
  def up
    execute "ALTER EXTENSION pgcrypto SET SCHEMA pg_catalog;"
  end

  def down
    execute "ALTER EXTENSION pg_catalog SET SCHEMA pgcrypto;"
  end
end
