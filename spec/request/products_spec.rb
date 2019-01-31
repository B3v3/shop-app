require 'rails_helper'

RSpec.describe 'Products', :type => :request do
  let(:product) { build(:product) }
  let(:saved_product) { create(:product1) }

  describe 'GET' do
    describe 'index' do
      it 'should get all products' do
        product.save
        products = [product, saved_product]
        get '/products'
        expect(assigns(:products)).to eq(products)
      end
    end

    describe 'show' do
      it 'should get specific product' do
        get "/products/#{saved_product.slug}"
        expect(assigns(:product)).to eq(saved_product)
      end
    end

    describe 'new' do
      it 'should get new product' do
        get '/products/new'
        expect(assigns(:product)).to be_a_new(Product)
      end
    end

    describe 'edit' do
      it 'should get specific product' do
        get "/products/#{saved_product.slug}/edit"
        expect(assigns(:product)).to eq(saved_product)
      end
    end
 end

  describe 'POST' do
    describe 'create' do
      it "should create a new product when params are valid" do
        expect{ post '/products', params: { product: attributes_for(:product)}}
        .to change(Product, :count).by(1)
      end

      it "should create anything when params are invalid" do
        expect{ post '/products', params: { product: attributes_for(:product, name: "")}}
        .to change(Product, :count).by(0)
      end
    end
  end

  describe 'PUT' do
    describe 'update' do
      it 'should change something when params are valid' do
        put "/products/#{saved_product.slug}", params: { product: { name: 'Cherry Cola' }}
        saved_product.reload
        expect(saved_product.name).to eql('Cherry Cola')
      end

      it "shouldn't change anything when params are invalid" do
        put "/products/#{saved_product.slug}", params: { product: { name: ' ' }}
        saved_product.reload
        expect(saved_product.name).not_to eql(' ')
      end
    end
  end

  describe 'Dekete'do
    describe 'destroy' do
      it "deletes product" do
        saved_product
        expect{ delete "/products/#{saved_product.slug}" }
        .to change(Product, :count).by (-1)
      end
    end
  end
end
