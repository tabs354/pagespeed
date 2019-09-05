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
      route_send = post domain_name_services_path, params: {domain_name_service: domain_name_service}
      expect(route_send).to redirect_to(new_user_session_path)
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


  describe 'Get Edit method' do
    let(:admin) {create(:user, role: :admin)}
    let(:staff1) {create(:user, email: 'staff1@foobar.com')}
    let(:staff2) {create(:user, email: 'staff2@foobar.com')}
    let(:domain_name_service_new) {create(:domain_name_service,url: 'onepiece.com', https: true, status: :on,user: staff1)}
    it 'will redirect to other page if not login' do
      get edit_domain_name_service_path(domain_name_service_new)
      expect(response).to have_http_status(302)
    end
    it 'Checking who can access DomainNameService edit page if admin ,the same staff or the other staff' do
      sign_in admin
      get edit_domain_name_service_path(domain_name_service_new)
      expect(response).to have_http_status(200)
      sign_out admin

      sign_in staff1
      get edit_domain_name_service_path(domain_name_service_new)
      expect(response).to have_http_status(200)
      sign_out staff1

      sign_in staff2
      get edit_domain_name_service_path(domain_name_service_new)
      expect(response).to have_http_status(302)
    end

  end


  describe 'get show method' do
    let(:admin) {create(:user, role: :admin)}
    let(:staff1) {create(:user, email: 'staff1@foobar.com')}
    let(:staff2) {create(:user, email: 'staff2@foobar.com')}
    let(:domain_name_service_new) {create(:domain_name_service,url: 'onepiece.com', https: true, status: :on,user: staff1)}
    it 'will redirect to other page if not login' do
      route_send = get domain_name_service_path(domain_name_service_new)
      expect(route_send).to redirect_to(root_path)
      expect(response).to have_http_status(302)
    end
    it 'Checking who can access DomainNameService edit page if admin ,the same staff or the other staff' do
      sign_in admin
      get domain_name_service_path(domain_name_service_new)
      expect(response).to have_http_status(200)
      sign_out admin

      sign_in staff1
      get domain_name_service_path(domain_name_service_new)
      expect(response).to have_http_status(200)
      sign_out staff1

      sign_in staff2
      get domain_name_service_path(domain_name_service_new)
      expect(route_send).to redirect_to(root_path)
      expect(response).to have_http_status(302)
    end
  end

  describe 'Patch method update function' do
    let(:admin) {create(:user, role: :admin)}
    let(:staff1) {create(:user, email: 'staff1@foobar.com')}
    let(:staff2) {create(:user, email: 'staff2@foobar.com')}
    let(:domain_name_service_new) {create(:domain_name_service,url: 'onepiece.com', https: true, status:'on',user: staff1)}

    it 'will redirect to other page if not login' do
      domain_name_service_update = {url: 'twopiece.com', https: true, status: 'on',user: staff1}
      route_check =patch domain_name_service_path(domain_name_service_new), params: {domain_name_service: domain_name_service_update }
      expect(response).to have_http_status(302)
      expect(route_check).to redirect_to(new_user_session_path)
    end

    it 'checking who is updating the DomainNameService' do
      sign_in admin
      domain_name_service_update = {url: 'twopiece.com', https: true, status: 'on',user: staff1}
      route_send = patch domain_name_service_path(domain_name_service_new), params: {domain_name_service: domain_name_service_update }
      domain_name_service_new.reload
      expect(route_send).to redirect_to(domain_name_service_path(domain_name_service_new))
      expect(domain_name_service_new.url).to eq(domain_name_service_update[:url])
      expect(domain_name_service_new.https).to eq(domain_name_service_update[:https])
      expect(domain_name_service_new.status).to eq(domain_name_service_update[:status])
      sign_out admin

      sign_in staff1
      domain_name_service_update = {url: 'threepiece.com', https: true, status:'on'}
      route_send = patch domain_name_service_path(domain_name_service_new), params: {domain_name_service: domain_name_service_update }
      domain_name_service_new.reload
      expect(route_send).to redirect_to(domain_name_service_path(domain_name_service_new))
      expect(domain_name_service_new.url).to eq(domain_name_service_update[:url])
      expect(domain_name_service_new.https).to eq(domain_name_service_update[:https])
      expect(domain_name_service_new.status).to eq(domain_name_service_update[:status])
      sign_out staff1

      sign_in staff2
      domain_name_service_update = {url: 'fourpiece.com', https: false, status: :off}
      route_send = patch domain_name_service_path(domain_name_service_new), params: {domain_name_service: domain_name_service_update }
      expect(domain_name_service_new.url).not_to eq(domain_name_service_update[:url])
      expect(domain_name_service_new.https).not_to eq(domain_name_service_update[:https])
      expect(domain_name_service_new.status).not_to eq(domain_name_service_update[:status])
      expect(route_send).to redirect_to(root_path)

    end
  end

end