module PagespeedResultDaily
  def self.get
    domain_name_services = DomainNameService.all
    domain_name_services.each do |domain_name_service|
      begin
        @result = RestClient.get('https://www.googleapis.com/pagespeedonline/v5/runPagespeed',
                                 {params: {url: domain_name_service.set_url,
                                           key: "AIzaSyAvi9yRt5Jp6hcaKdKquA_QSzmXfPTk_Qg"}})
      rescue RestClient::ExceptionWithResponse => result
        error =  ActiveSupport::JSON.decode(result.response)
        Rails.logger.info error["error"]["message"]
      else
        Rails.logger.info 'It worked!'
        @result = ActiveSupport::JSON.decode(@result)
        @field_data = @result["loadingExperience"]
        @origin_data = @result["originLoadingExperience"]
        @lighthouse_audits = @result["lighthouseResult"]["audits"]

        @pagespeed_insight = PagespeedInsightsController.helpers.set_parameters(@field_data, @origin_data, @lighthouse_audits, domain_name_service.pagespeed_insights.new)
        @pagespeed_insight.save
      end
    end
  end
end