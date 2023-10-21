class AddStatusColumnToSubdomainQuizEnrolled < ActiveRecord::Migration[7.0]
  def change
    add_column :subdomain_quiz_enrollments, :status, :integer, default: 0
  end
end
