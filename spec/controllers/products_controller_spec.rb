require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { build(:product) }
  let(:saved_product) { create(:product1) }

  describe 'GET' do
    describe '.index' do
      it 'should get all products' do
        product.save
        products = [product, saved_product]
        get 'index'
        expect(assigns(:products)).to eq(products)
      end
    end

    describe '.show' do
      it 'should get specific product' do
        get 'show', params: {  id: saved_product.slug }
        expect(assigns(:product)).to eq(saved_product)
      end
    end

    describe '.new' do
      it 'should get new product' do
        get 'new'
        expect(assigns(:product)).to be_a_new(Product)
      end
    end

    describe '.edit' do
      it 'should get specific product' do
        get 'edit', params: {  id: saved_product.slug }
        expect(assigns(:product)).to eq(saved_product)
      end
    end
 end
end
