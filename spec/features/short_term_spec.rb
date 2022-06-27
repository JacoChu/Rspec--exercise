require 'rails_helper'

RSpec.feature "ShortTerms", type: :feature do
  scenario "short-term parking" do
    user = User.create!( :email => "foobar@example.com", :password => "12345678")
    sign_in(user)

    visit "/"
    choose "短期費率"

    click_button "開始計費"

    click_button "結束計費"

    expect(page).to have_content("¥2.00")
  end
end
