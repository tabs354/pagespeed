class PagespeedInsightsController < ApplicationController
  include PagespeedInsightsHelper
  before_action :authenticate_user!

  def show
    domain_name_service = DomainNameService.find(params[:domain_name_service_id])
    begin
      @result = RestClient.get('https://www.googleapis.com/pagespeedonline/v5/runPagespeed',
                               { params: {url: "https://" + domain_name_service.dns,
                                         key: "AIzaSyAvi9yRt5Jp6hcaKdKquA_QSzmXfPTk_Qg"} })
    rescue RestClient::ExceptionWithResponse => result
      Rails.logger.info result.response
      error =  ActiveSupport::JSON.decode(result.response)
      flash[:danger] = error
      redirect_to domain_name_services_path
    else
      Rails.logger.info 'It worked!'
      @result = ActiveSupport::JSON.decode(@result)
      @field_data = @result["loadingExperience"]
      @origin_data = @result["originLoadingExperience"]
      @lighthouse_audits = @result["lighthouseResult"]["audits"]

      @pagespeed_insight = domain_name_service.pagespeed_insights.new
      record_data(set_parameters(@field_data, @origin_data, @lighthouse_audits, @pagespeed_insight))
    end
  end

  def record_data(pagespeed_insight)
    if pagespeed_insight.save
      flash[:success] = "Pagespeed analysis result was successfully recorded"
    else
      flash[:danger] = "Something went wrong in recording the pagespeed analysis result"
    end
  end

end