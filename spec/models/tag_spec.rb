require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) {build(:tag)}

  describe 'validations' do
    it "should accept valid model" do
      expect(tag).to be_valid
    end

    describe 'name' do
      it "should be present" do
        tag.name = nil
        expect(tag).to be_invalid
      end

      it "should be unique" do
        tag.save
        new_tag = build(:tag)
        expect(new_tag).to be_invalid
      end

      it "should be longer than 2 characters" do
        tag.name = "aa"
        expect(tag).to be_invalid
      end

      it "should be shorter than 20 characters" do
        tag.name = "a"*20
        expect(tag).to be_invalid
      end
    end
  end
end
