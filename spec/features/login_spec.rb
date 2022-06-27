require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  scenario "login and logout" do

    user = User.create!( :email => "foobar@example.com", :password => "12345678")

    visit "/users/sign_in"

    within("#new_user") do
      fill_in "Email", with: "foobar@example.com"
      fill_in "Password", with: "12345678"
    end

    click_button "Log in"
    expect(page).to have_content("Signed in successfully")

    click_link "登出"
    expect(page).to have_content("Signed out successfully")
  end
end
