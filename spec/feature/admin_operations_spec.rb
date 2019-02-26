describe "admin operations spec", type: :feature do
  let(:user)    {create(:user)}
  let(:admin)   {create(:admin)}
  let(:product) {create(:product)}
  let(:not_created_product) {build(:product)}

  before(:each) do
    user; admin;
    log_in_capybara(user)
  end

  describe 'creating new product' do
    it 'should show link to create new product in main page' do
      visit '/'
      expect(page).to have_link('Create a new product')
      end

    scenario 'sucessfully creating new product' do
      visit '/products/new'
      expect{
      within("#new_product") do
        fill_in 'product_description', with: not_created_product.description
        fill_in 'product_name',        with: not_created_product.name
        fill_in 'product_price',       with: not_created_product.price
      end
      click_button 'Submit'}.to change(Product, :count).by(1)

      expect(page).to have_content(not_created_product.description)
      expect(page).to have_content(not_created_product.name)
      expect(page).to have_content(not_created_product.price)
      expect(page).to have_current_path(product_path(Product.last))
    end

    scenario 'not sucessfully creating new product' do
      visit '/products/new'
      expect{
      within("#new_product") do
        fill_in 'product_description', with: " "
        fill_in 'product_name',        with: not_created_product.name
        fill_in 'product_price',       with: not_created_product.price
      end
      click_button 'Submit'}.not_to change(Product, :count)
      expect(page).to have_content("Description can't be blank")
    end
  end

  describe 'operations on products' do
    before(:each) do
      product
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
