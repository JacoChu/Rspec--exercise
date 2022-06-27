require 'rails_helper'

RSpec.feature 'parking', type: :feature do

  scenario "guest parking" do
    visit "/"            

    expect(page).to have_content("一般費率") 

    click_button "開始計費"
    
    click_button "結束計費"

    expect(page).to have_content("¥2.00")  
  end

end