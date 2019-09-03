module PagespeedResultDaily
  def self.get
    domain_name_services = DomainNameService.all
    domain_name_services.each do |domain_name_service|
      begin
        @result = RestClient.get(Rails.application.config_for(:google_pai)['pagespeed_endpoint'],
                                 {params: {url: domain_name_service.set_url,
                                           key: Rails.application.config_for(:google_pai)['api_key']}})
      rescue RestClient::ExceptionWithResponse => result
        error = ActiveSupport::JSON.decode(result.response)
        Rails.logger.info error['error']['message']
      else
        Rails.logger.info 'It worked!'
        @result = ActiveSupport::JSON.decode(@result)
        @field_data = @result['loadingExperience']
        @origin_data = @result['originLoadingExperience']
        @lighthouse_audits = @result['lighthouseResult']['audits']

        @pagespeed_insight = PagespeedInsightsController.helpers.set_parameters(@field_data, @origin_data, @lighthouse_audits, PagespeedInsight.new)
        @pagespeed_insight.domain_name_service = domain_name_service
        @pagespeed_insight.save
      end
    end
  end
end