require 'rails_helper'

RSpec.describe DomainNameService, type: :model do

  it 'url will be remove prefix https:// or http://' do
    domain_name_service = build(:domain_name_service, url: Faker::Internet.url(path: nil, scheme: 'http'))
    domain_name_service.clear_prefix
    expect(domain_name_service.url).to_not include('https://')
    expect(domain_name_service.url).to_not include('http://')

    domain_name_service.url = Faker::Internet.url(path: nil, scheme: 'https')
    domain_name_service.clear_prefix
    expect(domain_name_service.url).to_not include('https://')
    expect(domain_name_service.url).to_not include('http://')

    domain_name_service.url = 'foo.bar.com'
    domain_name_service.clear_prefix
    expect(domain_name_service.url).to_not include('https://')
    expect(domain_name_service.url).to_not include('http://')
  end

end