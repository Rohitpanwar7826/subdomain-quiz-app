class Subdomain::QuestionPolicy < ApplicationPolicy

  def new?
    has_role_teacher?
  end

  def create?
    new?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
