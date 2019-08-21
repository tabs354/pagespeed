class DomainNameServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dns, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:update, :edit, :show]

  def index
    @domain_name_services = current_user.admin? ? DomainNameService.all : current_user.domain_name_services
    @domain_name_services = @domain_name_services.where(status: params[:status]) if params[:status]
    @domain_name_services = @domain_name_services.includes(:user).page(params[:page]).per(6)
  end

  def new
    @domain_name_service = DomainNameService.new
  end

  def create
    @domain_name_service = current_user.domain_name_services.new(dns_params)
    if @domain_name_service.save
      flash[:success] = "Domain Name Service was successfully created"
      redirect_to domain_name_service_path(@domain_name_service)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @domain_name_service.update(dns_params)
      flash[:success] = "Domain Name Service was successfully updated"
      redirect_to domain_name_service_path(@domain_name_service)
    else
      render :edit
    end
  end

  private
  def dns_params
    params.require(:domain_name_service).permit(:dns, :https, :status)
  end

  def set_dns
    @domain_name_service = DomainNameService.find(params[:id])
  end

  def require_same_user
    unless current_user == @domain_name_service.user or current_user.admin?
      flash[:danger] = "You can only edit or update your own DNS"
      redirect_to root_path
    end
  end
end
