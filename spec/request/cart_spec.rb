require 'rails_helper'

RSpec.describe 'Cart', :type => :request do
  let(:user) {create(:user)}
  let(:user1) {create(:user1)}

  before(:each) do
    create(:product)
  end

  describe 'not logged in' do
    describe 'cart' do
      it "should redirect to login page" do
        get '/cart'
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not set up a order" do
        expect { get '/cart' }.not_to change(Order, :count)
      end
    end

    describe 'buying' do
      it "should redirect to login page" do
        put '/cart'
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not start a new order" do
        expect{ put '/cart'}.not_to change(Order, :count)
      end
    end

    describe 'clearning cart' do
      it "should redirect to login page" do
        delete '/cart'
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    describe 'adding to cart' do
      it "should redirect to login page" do
        post '/ordered_products', params: { product_id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not create a new ordered product" do
        expect { post '/ordered_products', params: { product_id: 1 }}
        .not_to change(OrderedProduct, :count)
      end
    end
  end

  describe 'logged in' do
    before(:each) do
      sign_in(user)
    end

    describe 'setting up cart' do
      it "should set up a empty order" do
        expect { get '/cart' }.to change(Order, :count).by (1)
        expect(Order.last.user).to eq(user)
      end

      it "should create new cart when order doesnt belong to user" do
        get '/cart'

        sign_in(user1)
        expect { get '/cart' }.to change(Order, :count).by (1)
        expect(Order.last.user).to eq(user1)
      end

      it "should create a new cart when order is done" do
        create(:order, status: "Done")
        expect { get '/cart' }.to change(Order, :count).by (1)
      end

      it "should not create a new cart when order is not done" do
        create(:order)
        expect { get '/cart' }.not_to change(Order, :count)
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

    describe 'deleting products from cart' do
      before(:each) do
        post '/ordered_products', params: { product_id: 1 }
      end

      it "should destroy a ordered product" do
        expect { delete '/cart', params: { id: 1 }}
        .to change(OrderedProduct, :count).by(-1)
      end

      it "should redirect to cart site" do
        delete '/cart', params: { id: 1 }
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

      describe 'not-empty cart' do
        before(:each) do
          create(:ordered_product)
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

      describe 'empty cart' do
        it 'should not change status of current order' do
          expect(Order.first.status).to eql("In progress")
          put '/cart'
          Order.first.reload
          expect(Order.first.status).to eql("In progress")
        end

        it "should start a new order" do
          expect{ put '/cart'}.not_to change(Order, :count)
        end
      end
    end
  end
end
