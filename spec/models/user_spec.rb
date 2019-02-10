require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  describe ".is_admin?" do
    it "returns true if user is admin" do
      Admin.create(user_id: user.id)
      expect(user.is_admin?).to be_truthy
    end

    it "returns false if user isnt admin" do
      expect(user.is_admin?).to be_falsey
    end
  end

  describe ".set_admin" do
    it "set user as admin if he isn't" do
      expect(user.is_admin?).to be_falsey
      user.set_admin
      user.reload
      expect(user.is_admin?).to be_truthy
    end

    it "dont do anything if user is admin" do
      Admin.create(user_id: user.id)
      expect(user.is_admin?).to be_truthy

      expect{ user.set_admin }.not_to change(Admin, :count)
    end
  end
end
