require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @product = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product detail page clicking on the product" do
    # ACT
    visit root_path
    first(".product").find_link("Details").click()

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_css 'section.products-show'
  end

end
