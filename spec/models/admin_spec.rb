require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:user) {create(:user)}
  let(:admin) {build(:admin)}

  describe 'validations' do
    it "should accept a valid admin model" do
      user
      expect(admin).to be_valid
    end

    it "should require a user id" do
      admin.id = ''
      expect(admin).to be_invalid
    end
  end
end
