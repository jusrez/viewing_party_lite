require 'rails_helper'

RSpec.describe 'Register User Page', type: :feature do
  describe 'When a user visits the /register path' do
    # it 'shows a form to register with a name, unique email, and a register button' do
    #   visit '/register'

    #   fill_in 'Name', with: ''
    #   fill_in 'Email', with: '1234'
    #   click_button 'Register User'

    #   expect(current_path).to eq '/register'
    #   expect(page).to have_content 'Error'

    #   fill_in 'Name', with: 'Sally Smith'
    #   fill_in 'Email', with: 'sallysmith@gmail.com'
    #   click_button 'Register User'

    #   sally = User.all.last
    #   expect(current_path).to eq user_path(sally.id)
    # end

    it 'shows a form to register with a name, email, password, and password confirmation. When I fill in the form with my name, email and matching passwords, Im taken to my dashboard page' do
      visit '/register'
       
      fill_in 'Name', with: 'Dirk Nowitzki'
      fill_in 'Email', with: 'dirk@nba.com'
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'dirkmightbethechamp'
      click_button 'Register User'

      expect(current_path).to eq '/register'
      expect(page).to have_content 'Error'

      fill_in 'Name', with: 'Dirk Nowitzki'
      fill_in 'Email', with: 'dirk@nba.com'
      fill_in 'Password', with: 'DirkIsTheChamp'
      fill_in 'Password confirmation', with: 'DirkIsTheChamp'
      click_button 'Register User'
    
      new_user = User.all.last
      expect(current_path).to eq user_path(new_user.id)
    end
  end
end
