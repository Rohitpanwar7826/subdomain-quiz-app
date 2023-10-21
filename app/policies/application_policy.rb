# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end


  def has_role_teacher?
    @user.has_role?(:teacher)
  end

  def has_role_student?
    @user.has_role?(:student)
  end

  def has_role_student_or_teacher?
    @user.has_role?(:student) || has_role_teacher?
  end


  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
