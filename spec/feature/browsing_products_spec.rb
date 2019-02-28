describe "browsing products", type: :feature do
let(:user) {create(:user)}
let(:product) {create(:product)}
let(:product1) {create(:product1)}

  context 'all users' do
    describe 'main page' do
      it "should show all products" do
        product
        product1

        visit "/"
        expect(page).to have_content "#{product.price}"
        expect(page).to have_link("#{product.name}", href: "/products/#{product.slug}")

        expect(page).to have_content "#{product1.price}"
        expect(page).to have_link("#{product1.name}", href: "/products/#{product1.slug}")
      end

      it "should show specific message when there are no products" do
        visit "/"
        expect(page).to have_content "Nothing at all ):"
      end

      describe 'browsing by tag' do
        it "should show only products with specific tag" do
          product
          tag = create(:tag)
          product1 = create(:product1, tag_id: tag.id)

          visit "/tags/#{tag.slug}"

          expect(page).to have_content "#{product1.price}"
          expect(page).to have_link("#{product1.name}", href: "/products/#{product1.slug}")

          expect(page).not_to have_content "#{product.price}"
          expect(page).not_to have_link("#{product.name}", href: "/products/#{product.slug}")
        end
      end
    end

    describe 'product page' do
      it "should show product information" do
        visit "/products/#{product.slug}"

        expect(page).to have_content "#{product.name}"
        expect(page).to have_content "#{product.price}"
        expect(page).to have_content "#{product.description}"
      end

      it "should not show add to cart button when not logged in" do
        visit "/products/#{product.slug}"
        expect(page).not_to have_button "Add to Cart"
      end
    end
  end

  context 'logged user' do
    before(:each) do
      log_in_capybara(user)
    end

    describe 'product page' do
      it "should show add to cart button" do
        visit "/products/#{product.slug}"
        expect(page).to have_button "Add to Cart"
      end
    end
  end
end
