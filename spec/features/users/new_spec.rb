require 'rails_helper'

RSpec.describe 'Register User Page', type: :feature do
  describe 'When a user visits the /register path' do
    it 'shows a form to register with a name, email, password, and password confirmation. When I fill in the form with my name, email and matching passwords, Im taken to my dashboard page' do
    
      visit '/register'

      fill_in 'Name', with: 'Dirk Nowitzki'
      fill_in 'Email', with: 'dirk@nba.com'
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'DirkIsTheChamp'
      click_button 'Register User'
    
      new_user = User.all.last
      expect(current_path).to eq user_path(new_user.id)
    end

    it 'and i fail to fill in my name, unique email, or matching passwords im taken back to the register page and a flash message pops up telling me what went wrong' do
      
      visit '/register'

      #Testing password mismatch returns an error message
      fill_in 'Name', with: 'Dirk Nowitzki'
      fill_in 'Email', with: 'dirk@nba.com'
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'dirkmightbethechamp'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content "Error: Password confirmation doesn't match Password"

      #Testing absence of name returns an error message
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'dirk@nba.com'
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'DirkIsTheChamp'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content "Error: Name can't be blank"

      #Testing absence of email returns an error message
      fill_in 'Name', with: 'Dirk Nowitzki'
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'DirkIsTheChamp'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content "Error: Email is invalid"

      #Testing non unique email returns an error message
      original_user = create(:user)
      fill_in 'Name', with: 'Dirk Nowitzki'
      fill_in 'Email', with: "#{original_user.email}"
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'DirkIsTheChamp'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content 'Error: Email has already been taken'
    end
  end
end
