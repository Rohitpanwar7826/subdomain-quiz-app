class ChangePriceColumnStringToIntegerInPlan < ActiveRecord::Migration[7.0]
  def change
    change_column :plans, :price, 'integer USING CAST(price AS integer)'
  end
end
