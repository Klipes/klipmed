class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
  def user_not_authorized
    flash[:alert] = "Usuário não autorizado a realizar esta operação."
    redirect_to(request.referrer || root_path)
  end
  
  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    puts resource_or_scope
    if resource_or_scope.is_a?(User) || resource_or_scope == :user
      new_user_session_path
    elsif resource_or_scope.is_a?(Admin) || resource_or_scope == :admin
      new_admin_session_path
    else
      new_user_session_path      
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) || resource_or_scope == :user
      site_home_index_path
    elsif resource_or_scope.is_a?(Admin) || resource_or_scope == :admin
      admin_path
    else
      site_home_index_path
    end
  end
end
