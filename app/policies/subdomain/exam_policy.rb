module Subdomain
  class ExamPolicy < ApplicationPolicy

    def show?
      has_role_student?
    end

    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end
  end
end
