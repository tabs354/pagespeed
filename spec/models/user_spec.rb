require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}
  describe ".roles" do
    it 'admin?' do
      expect(user).not_to be_admin
      user.role = 'admin'
      expect(user).to be_admin
    end
  end
end
