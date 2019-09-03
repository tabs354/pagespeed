class PagespeedInsightsController < ApplicationController
  include PagespeedInsightsHelper
  before_action :authenticate_user!

  def show
    domain_name_service = DomainNameService.find(params[:domain_name_service_id])
    begin
      @result = RestClient.get(Rails.application.config_for(:google_pai)['pagespeed_endpoint'],
                               {params: {url: domain_name_service.set_url,
                                         key: Rails.application.config_for(:google_pai)['api_key']}})
    rescue RestClient::ExceptionWithResponse => result
      Rails.logger.info result.response
      error = ActiveSupport::JSON.decode(result.response)
      flash[:danger] = error['error']['message']
      redirect_to domain_name_services_path
    else
      Rails.logger.info 'It worked!'
      @result = ActiveSupport::JSON.decode(@result)
      @field_data = @result['loadingExperience']
      @origin_data = @result['originLoadingExperience']
      @lighthouse_audits = @result['lighthouseResult']['audits']

      @pagespeed_insight = set_parameters(@field_data, @origin_data, @lighthouse_audits, domain_name_service.pagespeed_insights.new)
      if @pagespeed_insight.save
        flash.now[:success] = 'Pagespeed analysis result was successfully recorded'
      else
        flash.now[:danger] = 'Something went wrong in recording the pagespeed analysis result'
      end
    end
  end
end