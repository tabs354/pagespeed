class DomainNameServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    params[:status] = "all" if params[:status] == nil
    if params[:status] == "all"
      @domain_name_services = DomainNameService.where(user_id: current_user.id).page(params[:page]).per(6)
    else
      @domain_name_services = DomainNameService.where(status: params[:status], user_id: current_user.id).page(params[:page]).per(6)
    end
  end
end
