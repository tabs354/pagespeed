require 'rails_helper'

RSpec.describe DomainNameService, type: :model do

  it 'Check if the https remove before save' do
    user = create(:user)
    domain_name_service = create(:domain_name_service, url:'https://www.google.com' ,user: user)
    expect(domain_name_service.url).to_not include("https://")
  end

  it 'Check if the http remove is before save' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:"http://iczn.org",user: user)
    expect(domain_name_service.url).to_not include("http://")
  end

  it 'Check if the https or http remove before save' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:'amazon.com',user: user)
    expect(domain_name_service.url).to_not include("https://") || include("http://")
  end


  it 'Check if the https remove before update' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:'https://www.google.com',user: user)
    domain_name_service.url = 'https://www.google.com'
    domain_name_service.save
    expect(domain_name_service.reload.url).to_not include("https://")
  end

  it 'Check if the http remove before update' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:'http://iczn.org',user: user)
    domain_name_service.url = 'http://iczn.org'
    domain_name_service.save
    expect(domain_name_service.reload.url).to_not include("http://")
  end
  it 'Check if the https or http remove before update' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:'amazon.com',user: user)
    domain_name_service.url = 'amazon.com'
    domain_name_service.save
    expect(domain_name_service.reload.url).to_not include("https://") || include("http://")
  end

  it 'Add https to the url if the https is true' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:'www.google.com',user: user)
    expect(domain_name_service.set_url).to include("https://")
  end

  it 'Add http to the url if the http is true' do
    user = create(:user)
    domain_name_service = create(:domain_name_service,url:'http://iczn.org',user: user)
    domain_name_service.https = false
    domain_name_service.save
    expect(domain_name_service.reload.set_url).to include("http://")
  end


end