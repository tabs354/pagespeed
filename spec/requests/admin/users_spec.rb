require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  describe "GET /admin/users" do
    let(:admin) {create(:user, role: :admin)}
    let(:staff) {create(:user, email: 'staff@foobar.com')}

    it 'will redirect to other page if not login' do
      get admin_users_path
      expect(response).to have_http_status(302)
    end

    it 'will redirect to other page if not admin' do
      sign_in staff
      get admin_users_path
      expect(response).to have_http_status(302)
    end

    it 'allow access admin user index page if admin' do
      sign_in admin
      get admin_users_path
      expect(response).to have_http_status(200)
    end

    it 'should view user after create user admin and staff' do
      new_user_admin = create(:user, email: 'admin@foobar.com', role: :admin)
      new_user_staff = create(:user, email: 'staff@foobar.com', role: :staff)

      sign_in admin
      get admin_users_path

      expect(response.body).to include(new_user_staff.email)
      expect(response.body).to include(new_user_admin.email)
    end
  end
end
