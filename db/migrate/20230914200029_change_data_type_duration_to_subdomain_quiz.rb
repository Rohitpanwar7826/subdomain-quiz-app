class ChangeDataTypeDurationToSubdomainQuiz < ActiveRecord::Migration[7.0]
  def change
    change_column :subdomain_quizzes, :duration, 'integer USING EXTRACT(EPOCH FROM duration)::INT'
  end
end
