module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_admin

    def index
      @users = User.page(params[:page]).per(6)
    end
    
    private
    def redirect_if_not_admin
      unless current_user.admin?
        flash[:alert] = "Only admin can do that action!!"
        redirect_to root_path
      end
    end
  end
end
