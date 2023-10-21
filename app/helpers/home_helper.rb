module HomeHelper
  def generate_role_according_url
    current_user.has_role?(:teacher) ? quizzes_path : enroll_students_path
  end
end
