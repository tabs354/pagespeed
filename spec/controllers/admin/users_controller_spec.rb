require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin) {create(:user, role: :admin)}
  let(:staff) {create(:user, email: 'staff@foobar.com')}

  it "should have a current_user if admin sign in and its ok to get index" do
    expect(subject.current_user).to eq(nil)
    sign_in admin
    expect(subject.current_user).to_not eq(nil)
    expect(subject.current_user).to eq(admin)
    get :index
    expect(response).to be_successful
  end

  it "should have a current_user if staff sign in but can't access admin page" do
    expect(subject.current_user).to eq(nil)
    sign_in staff
    expect(subject.current_user).to_not eq(nil)
    expect(subject.current_user).to eq(staff)
    get :index
    expect(response).to_not be_successful
    expect(response).to redirect_to(root_path)
  end
end
