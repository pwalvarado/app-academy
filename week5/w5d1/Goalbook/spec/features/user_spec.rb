feature "the user's page" do 
  
  given(:user) { FactoryGirl.create(:user) }
  given(:goal1) { FactoryGirl.build(:goal) }
  given(:goal2) { FactoryGirl.build(:goal) }
  
  before(:each) do
    log_in_user(user)
    create_public_goal(goal1)
    create_public_goal(goal2)
    visit user_url(user)
  end
  
  scenario "shows the user's goals" do
    expect(page).to have_content goal1.title
    expect(page).to have_content goal2.title
  end
end


private

def log_in_user(user)
  visit new_session_url
  fill_in 'Username', :with => user.username
  fill_in 'Password', :with => user.password
  click_on 'Sign In'
end

def create_public_goal(goal)
  visit new_goal_url
  fill_in 'Title', :with => goal.title
  fill_in 'Description', :with => goal.description
  choose('Yes')
  click_on 'Create Goal'
end