class AddTestDateColumnToSubdomainQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_quizzes, :test_date_time, :datetime
  end
end
