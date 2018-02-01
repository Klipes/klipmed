class ProfessionalPolicy < ApplicationPolicy
  
  def index?
    user.full_access?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end