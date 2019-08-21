class SearchesController < ApplicationController
  require 'rest-client'

  def new
  end

  def show
    dns = params['address']
    begin
      @result = RestClient.get('https://www.googleapis.com/pagespeedonline/v5/runPagespeed', {params: {url: dns, key: "AIzaSyAvi9yRt5Jp6hcaKdKquA_QSzmXfPTk_Qg"}})
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      puts 'Access denied'
      return err.response
    rescue RestClient::ImATeapot => err
      puts 'The server is a teapot! # RFC 2324'
      return err.response
    else
      puts 'It worked!'
      return @result = ActiveSupport::JSON.decode(@result)
    end
  end

end