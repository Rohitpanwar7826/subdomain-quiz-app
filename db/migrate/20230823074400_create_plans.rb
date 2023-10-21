class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :uuid, default: 'public.gen_random_uuid()' do |t|
      t.string :price
      t.string :no_students
      t.string :per_month
      t.string :name
      t.timestamps
    end
  end
end
