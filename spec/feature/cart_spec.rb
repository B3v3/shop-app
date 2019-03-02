describe "cart spec", type: :feature do
  let(:user) {create(:user)}
  let(:product) {create(:product)}
  let(:ordered_product) {create(:ordered_product)}

  describe 'link to cart' do
    context 'logged user' do
      before(:each) do
        log_in_capybara(user)
      end

      it "should show in header" do
        visit '/'
        expect(page).to have_content("Cart(0)")
      end

      it "should increase value when something added to cart" do
        product
        ordered_product

        visit '/'
        expect(page).to have_content("Cart(1)")
      end

      it "should decrease value when something is deleted from cart" do
        product
        ordered_product
        ordered_product.destroy

        visit '/'
        expect(page).to have_content("Cart(0)")
      end
    end

    context 'not logged user' do
      it "should not show in header" do
        visit '/'
        expect(page).not_to have_content("Cart(0)")
      end
    end
  end

  describe 'adding to cart' do
    before(:each) do
      product
      log_in_capybara(user)
    end

    it 'should redirect to cart page' do
      visit "/products/#{product.slug}"
      expect(page).to have_button('Add to Cart')
      click_button 'Add to Cart'
      expect(page).to have_current_path(cart_path)
    end

    it "should create new product in cart" do
      visit "/products/#{product.slug}"
      expect(page).to have_button('Add to Cart')
      click_button 'Add to Cart'
      expect(page).to have_content("Cart(1)")
    end
  end

  describe 'deleting from cart' do
    before(:each) do
      log_in_capybara(user)
      visit '/'
      product
      ordered_product
    end

    it "should delete product from cart" do
      visit '/cart'

      expect(page).to have_content('Delete from Cart')
      click_link 'Delete from Cart'
      expect(page).to have_content("Cart(0)")
    end

    it "should redirect to cart page" do
      visit '/cart'

      expect(page).to have_content('Delete from Cart')
      click_link 'Delete from Cart'
      expect(page).to have_current_path(cart_path)
    end
  end

  describe 'buying' do
    before(:each) do
      log_in_capybara(user)
      visit '/'
      product
      ordered_product
    end

    it "should change order status to Done" do
      visit '/cart'

      expect(page).to have_button('Buy')
      click_button('Buy')

      visit '/history'
      expect(page).to have_content(Order.last.updated_at)
    end

    it "should redirect to main page" do
      visit '/cart'

      expect(page).to have_button('Buy')
      click_button('Buy')
      expect(page).to have_current_path(root_path)
    end

    it "should refresh cart value" do
      visit '/cart'

      expect(page).to have_button('Buy')
      click_button('Buy')
      expect(page).to have_content("Cart(0)")
    end
  end

  describe 'clearning' do
    before(:each) do
      log_in_capybara(user)
      visit '/'
      product
      ordered_product
      ordered_product
    end

    it "should delete all ordered products" do
      visit '/cart'

      expect(page).to have_link('Clear Cart')
      click_link('Clear Cart')

      expect(page).to have_content("Cart(0)")
      expect(page).to have_content("Empty Cart ):")
    end

    it "should redirect to cart page" do
      visit '/cart'

      expect(page).to have_link('Clear Cart')
      click_link('Clear Cart')
      expect(page).to have_current_path(cart_path)
    end
  end
end
