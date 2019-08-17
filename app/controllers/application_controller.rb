class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :user_is_admin?

  def user_is_admin?
    if user_signed_in?
      if current_user.role == "admin"
        return true
      else
        return false
      end
    end
  end
end
