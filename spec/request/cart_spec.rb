require 'rails_helper'

RSpec.describe 'Products', :type => :request do

  before(:each) do
    create(:product)
  end

  describe 'setting up cart' do
    it "should set up a empty order" do
      expect { get '/cart' }.to change(Order, :count).by (1)
    end
  end

  describe 'adding products to cart' do
    it "should create a ordered product" do
      expect { post '/ordered_products', params: { product_id: 1 }}
      .to change(OrderedProduct, :count).by(1)
    end

    it "should associate ordered product with current order" do
      post '/ordered_products', params: { product_id: 1 }
      expect(Order.first.ordered_products).to include(OrderedProduct.first)
    end

    it "should redirect to cart site" do
      post '/ordered_products', params: { product_id: 1 }
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'clearning cart' do
    before(:each) do
      post '/ordered_products', params: { product_id: 1 }
    end

    it "should delete all ordered products from cart" do
      expect{ delete '/cart' }.to change(OrderedProduct, :count).by (-1)
    end

    it "should left empty cart" do
      delete '/cart'
      expect(Order.first.ordered_products.count).to eql(0)
    end

    it "shouldn't delete order" do
      expect{ delete '/cart' }.not_to change(Order, :count)
    end

    it "should redirect to cart site" do
      delete '/cart'
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'buying' do
    before(:each) do
      get '/cart'
    end

    it "should change status of current order" do
      expect(Order.first.status).to eql("In progress")
      put '/cart'
      Order.first.reload
      expect(Order.first.status).to eql("Done")
    end

    it "should start a new order" do
      expect{ put '/cart'}.to change(Order, :count).by(1)
    end
  end
end
