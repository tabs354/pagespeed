require 'rails_helper'
RSpec.describe "DomainNameServices", type: :request do
  describe 'GET index route for the domain name service' do
    let(:staff) {create(:user, email: 'staff@foobar.com', role: :staff)}
    let(:admin) {create(:user, email: 'admin@foobar.com', role: :admin)}
    it 'will redirect to other page if not login' do
      get domain_name_services_path
      expect(response).to have_http_status(302)
    end
    it 'allow access DomainNameServices index page if login' do
      sign_in staff
      get domain_name_services_path
      expect(response).to have_http_status(200)
    end
    it 'Count the list of domain_name_service in the index' do
      sign_in admin
      DomainNameService.create(url: 'google.com', https: true, status: :on, user: admin)
      DomainNameService.create(url: 'onepiece.com', https: true, status: :on, user: admin)
      get domain_name_services_path
      expect(DomainNameService.all.size).to be > 0
    end
  end
  describe 'Get New route for the domain name service' do
    let(:admin) {create(:user, role: :admin)}
    it 'will redirect to other page if not login' do
      get new_domain_name_service_path
      expect(response).to have_http_status(302)
    end
    it 'allow access DomainNameService index page if login' do
      sign_in admin
      get new_domain_name_service_path
      expect(response).to have_http_status(200)
    end
    it 'check if there is a new instance Domain Name Service' do
      sign_in admin
      get new_domain_name_service_path
      expect(DomainNameService.new).to be_a_new(DomainNameService)
    end
  end

  describe 'Post method for create for the domain name service' do
    let(:admin) {create(:user, role: :admin)}
    let(:staff) {create(:user, email: 'staff@foobar.com')}
    it 'will redirect to other page if not login' do
      domain_name_service = {url: 'onepiece.com', https: true, status: :on}
      post domain_name_services_path, params: {domain_name_service: domain_name_service}
      expect(response).to have_http_status(302)
    end
    it 'Check if the Domain name service was insert' do
      sign_in admin
      domain_name_service = {url: 'onepiece.com', https: true, status: :on}
      expect {
        post domain_name_services_path, params: {domain_name_service: domain_name_service}
      }.to change {DomainNameService.count}
    end
  end

end