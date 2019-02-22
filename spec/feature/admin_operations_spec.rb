describe "admin operations spec", type: :feature do
  let(:user)    {create(:user)}
  let(:admin)   {create(:admin)}
  let(:product) {create(:product)}

  describe 'creating new product' do
    it 'should show link to create new product in main page' do

    end

    scenario 'sucessfully creating new product' do

    end

    scenario 'not sucessfully creating new product' do

    end
  end

  describe 'operations on products' do
    before(:each) do
      user; admin; product
      log_in_capybara(user)
    end

    describe 'editing product' do
      it "should show link to edit in product page" do
        visit "/products/#{product.slug}"
        expect(page).to have_link('Edit product')
      end

      scenario 'sucessfully editing product' do
        visit "/products/#{product.slug}/edit"
        fill_in 'product_name', with: 'hello'
        click_button 'Submit'
        expect(page).to have_current_path(product_path(product))
        expect(page).to have_content('hello')
      end

      scenario 'not sucessfully editing product' do
        visit "/products/#{product.slug}/edit"
        fill_in 'product_name', with: 'xy'
        click_button 'Submit'
        expect(page).to have_content("Name is too short (minimum is 3 characters)")
      end
    end

    describe 'deleting product' do
      it "should show link to delete product in edit page" do
        visit "/products/#{product.slug}/edit"
        expect(page).to have_link('Delete')
      end

      scenario 'sucessfully deleting product' do
        visit "/products/#{product.slug}/edit"
        expect(page).to have_link('Delete')
        click_link('Delete')
        expect(page).to have_current_path(root_path)
        expect(page).not_to have_content("#{product.name}")
        expect(page).to have_content("Nothing at all ):")
      end
    end
  end
end
