class IpApisController < ApplicationController
  def show
  end

  def search
    begin
      @result = RestClient.get("http://ip-api.com/json/#{params[:ip_api]}")
    rescue RestClient::ExceptionWithResponse => result
      Rails.logger.info result.response
      error = ActiveSupport::JSON.decode(result.response)
      flash.now[:danger] = error['error']['message']
    else
      Rails.logger.info 'It worked!'
      @ip_api = ActiveSupport::JSON.decode(@result)
      if @ip_api['status'] == 'fail'
        flash.now[:danger] =  @ip_api['message']
      end
      respond_to do |format|
        format.js {render partial: 'ip_apis/search'}
      end
    end
  end
end