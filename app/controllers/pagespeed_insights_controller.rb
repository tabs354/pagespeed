class PagespeedInsightsController < ApplicationController
  require 'rest-client'
  before_action :authenticate_user!

  def show
    domain_name_service = DomainNameService.find(params[:domain_name_service_id])
    begin
      @result = RestClient.get('https://www.googleapis.com/pagespeedonline/v5/runPagespeed',
                               { params: {url: "https://" + domain_name_service.dns,
                                         key: "AIzaSyAvi9yRt5Jp6hcaKdKquA_QSzmXfPTk_Qg"} })
    rescue RestClient::ExceptionWithResponse => result
      puts result.response
      error =  ActiveSupport::JSON.decode(result.response)
      flash[:danger] = error
      redirect_to domain_name_services_path
    else
      puts 'It worked!'
      @result = ActiveSupport::JSON.decode(@result)
    end
  end
end