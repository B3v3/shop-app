require 'rails_helper'

RSpec.describe 'Products', :type => :request do
  let(:product) { build(:product) }
  let(:saved_product) { create(:product1) }
  let(:user) {create(:user)}

  describe 'logged in' do
    before(:each) do
      sign_in(user)
    end

    describe 'user is admin' do
      before(:each) do
        user.set_admin
        user.reload
      end

      describe 'GET' do
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

          it "shouldnt create anything when params are invalid" do
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

      describe 'Delete'do
        describe 'destroy' do
          it "deletes product" do
            saved_product
            expect{ delete "/products/#{saved_product.slug}" }
            .to change(Product, :count).by (-1)
          end
        end
      end
    end

    describe 'user is not admin' do
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
          it 'should redirect to login page' do
            get '/products/new'
            expect(response).to redirect_to(root_path)
          end
        end

        describe 'edit' do
          it 'should redirect to login page' do
            get "/products/#{saved_product.slug}/edit"
            expect(response).to redirect_to(root_path)
          end
        end
     end

      describe 'POST' do
        describe 'create' do
          it "should create nothing" do
            expect{ post '/products', params: { product: attributes_for(:product)}}
            .not_to change(Product, :count)
          end

          it 'should redirect to login page' do
            post '/products', params: { product: attributes_for(:product, name: "")}
            expect(response).to redirect_to(root_path)
        end
      end

      describe 'PUT' do
        describe 'update' do
          it 'should redirect to login page' do
            put "/products/#{saved_product.slug}", params: { product: { name: 'Cherry Cola' }}
            saved_product.reload
            expect(response).to redirect_to(root_path)
          end

          it "shouldn't change anything" do
            put "/products/#{saved_product.slug}", params: { product: { name: ' ' }}
            saved_product.reload
            expect(saved_product.name).not_to eql(' ')
          end
        end
      end

      describe 'Delete'do
        describe 'destroy' do
            it "deletes nothing" do
              saved_product
              expect{ delete "/products/#{saved_product.slug}" }
              .not_to change(Product, :count)
            end

            it "should redirect to login page" do
              saved_product
              delete "/products/#{saved_product.slug}"
              expect(response).to redirect_to(root_path)
            end
          end
        end
      end
    end
  end

  describe 'not logged in' do
    describe 'GET' do
      describe 'new' do
        it 'should redirect to login page' do
          get '/products/new'
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe 'edit' do
        it 'should redirect to login page' do
          get "/products/#{saved_product.slug}/edit"
          expect(response).to redirect_to(new_user_session_path)
        end
      end
   end

    describe 'POST' do
      describe 'create' do
        it "should create nothing" do
          expect{ post '/products', params: { product: attributes_for(:product)}}
          .not_to change(Product, :count)
        end

        it 'should redirect to login page' do
          post '/products', params: { product: attributes_for(:product, name: "")}
          expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT' do
      describe 'update' do
        it 'should redirect to login page' do
          put "/products/#{saved_product.slug}", params: { product: { name: 'Cherry Cola' }}
          saved_product.reload
          expect(response).to redirect_to(new_user_session_path)
        end

        it "shouldn't change anything" do
          put "/products/#{saved_product.slug}", params: { product: { name: ' ' }}
          saved_product.reload
          expect(saved_product.name).not_to eql(' ')
        end
      end
    end

    describe 'Delete'do
      describe 'destroy' do
          it "deletes nothing" do
            saved_product
            expect{ delete "/products/#{saved_product.slug}" }
            .not_to change(Product, :count)
          end

          it "should redirect to login page" do
            saved_product
            delete "/products/#{saved_product.slug}"
            expect(response).to redirect_to(new_user_session_path)
          end
        end
      end
    end
  end
end
