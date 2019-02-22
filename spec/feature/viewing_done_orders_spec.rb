
describe "viewing done products", type: :feature do
  let(:user) {create(:user)}

  feature 'coming to history page' do
    describe 'when logged in' do
      it "main page should show link history page" do
        log_in_capybara(user)
        visit '/'
        expect(page).to have_content 'History'
      end
    end

    describe 'when not logged in' do
      it "main page should not show link to history page" do
        visit '/'
        expect(page).not_to have_content 'History'
      end
    end
  end

  feature 'history page' do
    before(:each) do
      log_in_capybara(user)
    end

    it "should show all done orders" do
      product = create(:product)
      create(:ordered_product)
      order = Order.first
      order.buy
      order.reload

      visit '/history'

      expect(page).to have_content "Done at #{order.updated_at}"
      expect(page).to have_content "#{product.name}"
      expect(page).to have_content "Price - #{order.total_price}"
    end

    it "should show special text when none done orders" do
      visit '/history'
      expect(page).to have_content "None orders ):"
    end
  end
end
