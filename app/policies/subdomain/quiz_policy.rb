module Subdomain
  class QuizPolicy < ApplicationPolicy
    def index?
      has_role_teacher?
    end

    def new?
      index?
    end
  
    def create?
      new?
    end

    def show?
      has_role_student_or_teacher?
    end

    def question_partial?
      new?
    end
  
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end
  end
end
