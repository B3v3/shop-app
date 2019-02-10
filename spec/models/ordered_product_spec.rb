require 'rails_helper'

RSpec.describe OrderedProduct, type: :model do
  let(:ordered_product) { build(:ordered_product) }

  before(:each) do
    create(:user)
    create(:product)
    create(:order)
  end

  describe 'Validations' do
    it "should accept a valid ordered product" do
      expect(ordered_product).to be_valid
    end

    it "should have order_id" do
      ordered_product.order_id = nil
      expect(ordered_product).to be_invalid
    end

    it "should have product_id" do
      ordered_product.product_id = nil
      expect(ordered_product).to be_invalid
    end
  end

  describe 'Relationships' do
    it "should be associated with product" do
      expect(ordered_product.product).to eq(Product.first)
    end

    it "should be associated with order" do
      expect(ordered_product.order).to eq(Order.first)
    end
  end
end
