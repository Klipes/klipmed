class SupplierPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.user_configuration.supplier?
  end
end
