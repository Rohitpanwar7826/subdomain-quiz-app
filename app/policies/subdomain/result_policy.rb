class Subdomain::ResultPolicy < ApplicationPolicy
  def index?
    has_role_student_or_teacher?
  end

  def show?
    has_role_student_or_teacher?
  end

  class Scope < Scope
    def resolve
      user.roles_name.include?('teacher') ?
          scope.all.order(created_at: :desc)
          :
          user.results.includes(:subdomain_quiz).order(created_at: :desc)
    end
  end
end
