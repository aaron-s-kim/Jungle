require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do
  # SETUP - adds product using RSpec before :each block:
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They can add a product to the Cart" do
    # ACT
    visit root_path
    find_button("Add").click

    # VERIFY
    expect(page).to have_content("Cart (1)")
    # DEBUG
    save_screenshot
  end

end
