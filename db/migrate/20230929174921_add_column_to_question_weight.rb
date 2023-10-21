class AddColumnToQuestionWeight < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_questions, :weight, :integer
  end
end
