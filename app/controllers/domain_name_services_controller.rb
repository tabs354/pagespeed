class DomainNameServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @domain_name_services = current_user.domain_name_services
    if params[:status] == nil
      @domain_name_services = @domain_name_services.page(params[:page]).per(6)
    else
      @domain_name_services = @domain_name_services.where(status: params[:status]).page(params[:page]).per(6)
    end
  end
end
