require 'rails_helper'

RSpec.describe 'History', :type => :request do
  let(:user) { create(:user) }
  let(:order) { Order.first}
  
  describe 'GET history' do
    it "should show all done orders when logged" do
      sign_in(user)
      create(:order)
      create(:product)
      create(:ordered_product)
      order.buy
      order.reload
      get '/history'
      expect(assigns(:orders)).to eq([order])
    end

    it "should redirect to login page when not-logged in" do
      get '/history'
      expect(request).to redirect_to(new_user_session_path)
    end
  end
end
