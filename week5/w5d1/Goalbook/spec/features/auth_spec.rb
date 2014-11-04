require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => 'david'
      fill_in 'Password', :with => 'password1' 
      click_button 'Sign Up'
    end
    
    scenario "shows username on the user page after signup" do
      expect(page).to have_content 'david'
    end
  end

end

feature "logging in" do
  
  given(:user) { FactoryGirl.create(:user) }
  
  before(:each) do
    log_in_user(user)
  end

  scenario "shows username on the user page after login" do
    expect(page).to have_content user.username
  end

end

feature "logging out" do 

  it "begins with logged out state" do
    visit root_url
    expect(page).to have_content "Sign Up"
    expect(page).to have_content "Log In"
    expect(page).not_to have_content "Log Out"
  end

  it "doesn't show username on the homepage after logout" do
    user = FactoryGirl.create(:user)
    log_in_user(user)
    click_on 'Log Out'
    visit root_url
    expect(page).not_to have_content user.username
  end

end

feature "public/private goal setting" do
  
  given(:user) { FactoryGirl.create(:user) }
  given(:private_goal) { FactoryGirl.build(:goal) }
  given(:public_goal) { FactoryGirl.build(:goal) }
  
  
  before(:each) do
    log_in_user(user)
    create_private_goal(private_goal)
    create_public_goal(public_goal)
  end
  
  feature "a user's own goals" do
    
    before(:each) do
      visit user_url(user)
    end
    
    
    specify 'can be seen by the user (public and private)' do
      expect(page).to have_link private_goal.title
      expect(page).to have_link public_goal.title
    end
    
  end
  
  feature "a different user's goals" do
    
    given(:other_user) { FactoryGirl.create(:user) }
    
    before(:each) do
      log_in_user(other_user)
      visit user_url(user)
    end
    
    specify 'can be seen if public' do
      save_and_open_page
      expect(page).to have_link public_goal.title
    end
    
    specify 'can not be seen if private' do
      expect(page).not_to have_link private_goal.title
    end
    
    
    
  end
  
end

def create_private_goal(goal)
  visit new_goal_url
  fill_in 'Title', :with => goal.title
  fill_in 'Description', :with => goal.description
  choose('No')
  click_on 'Create Goal'
end

def create_public_goal(goal)
  visit new_goal_url
  fill_in 'Title', :with => goal.title
  fill_in 'Description', :with => goal.description
  choose('Yes')
  click_on 'Create Goal'
end

def log_in_user(user)
  visit new_session_url
  fill_in 'Username', :with => user.username
  fill_in 'Password', :with => user.password
  click_on 'Sign In'
end
