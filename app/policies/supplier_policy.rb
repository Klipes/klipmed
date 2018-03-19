class SupplierPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.user_policy.supplier?
  end
end
