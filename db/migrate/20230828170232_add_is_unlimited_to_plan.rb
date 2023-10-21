class AddIsUnlimitedToPlan < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :is_unlimited, :boolean, default: false
  end
end
