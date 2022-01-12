require 'rails_helper'

RSpec.feature "Visitor navigates from home to product detail page", type: :feature, js: true do

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

  scenario "They see product details" do
    # ACT
    visit root_path
    click_link("Details »", match: :first)

    # VERIFY
    expect(page).to have_css 'section.products-show', count: 1

    # DEBUG
    # puts page.html
    save_screenshot
  end

end
