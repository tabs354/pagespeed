class DomainNameServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @domain_name_services = current_user.domain_name_services
    @domain_name_services = @domain_name_services.where(status: params[:status]) if params[:status]
    @domain_name_services = @domain_name_services.page(params[:page]).per(6)
  end

  def new
    @domain_name_service = DomainNameService.new
  end

  def create
    @domain_name_service = current_user.domain_name_services.new(dns_params)
    @domain_name_service.dns = clear_prefix(dns_params[:dns])
    if @domain_name_service.save
      flash[:success] = "Domain Name Service was successfully created"
      redirect_to domain_name_services_path
    else
      render 'new'
    end
  end

  def show
    @domain_name_service = current_user.domain_name_services.find(params[:id])
  end

  def edit
  end

  def update

  end
  private
  def dns_params
    params.require(:domain_name_service).permit(:dns, :https, :status)
  end

  def clear_prefix(dns)
    dns.delete_prefix! "https://"
    dns.delete_prefix! "http://"
    dns
  end
end
