feature "the goal creation process" do
  
  scenario "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content "New Goal"
  end
  
  feature 'creates a goal' do
  
    given(:user) { FactoryGirl.create(:user) }
    given(:goal) { FactoryGirl.build(:goal) }
  
    before(:each) do
      log_in_user(user)
      create_private_goal(goal)
    end
  
    scenario "redirects to user's profile page" do
      expect(page).to have_content user.username
    end
  
    scenario "includes new goal in user's goal list" do
      expect(page).to have_content goal.title
    end
  end
end

feature "the goal page" do
  
  given(:user) { FactoryGirl.create(:user) }
  given(:goal) { FactoryGirl.build(:goal) }

  before(:each) do
    log_in_user(user)
    create_private_goal(goal)
    click_on goal.title
  end
  
  scenario "has the goal's title and description" do
    expect(page).to have_content goal.title
    expect(page).to have_content goal.description
  end
  
  scenario "identifies the goal's creator" do
    expect(page).to have_content user.username
  end
  
  scenario "has the goal's completion status" do
    expect(page).to have_content 'Incomplete'
  end
  
  scenario "has a link to edit the goal" do
    expect(page).to have_link 'Edit Goal'
  end

end

feature "the goal editing process" do
  
  given(:user) { FactoryGirl.create(:user) }
  given(:goal) { FactoryGirl.build(:goal) }

  before(:each) do
    log_in_user(user)
    create_private_goal(goal)
    click_on goal.title
    click_link "Edit Goal"
  end
  
  feature "the edit page" do
    
    
    scenario "has fields for title, description, completion status, and 
              public/private status" do
      expect(page).to have_content "Title"
      expect(page).to have_content "Description"
      expect(page).to have_content "Completed?"
      expect(page).to have_content "Public?"
    end
              
    scenario "has an 'Update Goal' button" do
      expect(page).to have_button "Update Goal"
    end
    
    scenario "contains some of the current attributes" do
      expect(find_field('Title').value).to eq(goal.title)
      expect(find_field('Description').value).to eq(goal.description)
    end
    
  end
  
  feature "the update process" do 
    
    feature "handles valid updates" do
      
      given(:new_goal) { FactoryGirl.build(:goal) }
  
      before(:each) do
        fill_in 'Title', with: new_goal.title
        fill_in 'Description', with: new_goal.description
        click_button 'Update Goal'
      end
  
      scenario "redirects to goal's page" do
        expect(page).to have_content "A goal of"
      end
  
      scenario "successfully updates attributes" do
        expect(page).to have_content new_goal.title
        expect(page).to have_content new_goal.description
      end
      
    end
    
    feature "handles invalid updates" do
      
      before(:each) do
        fill_in 'Title', with: ''
        fill_in 'Description', with: ''
        click_button 'Update Goal'
      end
      
      scenario "re-renders Edit page" do
        expect(page).to have_content "Edit Goal"
      end
  
      scenario "shows error messages for invalid attributes" do
        expect(page).to have_content "Title can't be blank"
        expect(page).not_to have_content "Description can't be blank"
      end
    end
  end
  
end

feature "the goal destruction process" do
  
  given(:user) { FactoryGirl.create(:user) }
  given(:goal) { FactoryGirl.build(:goal) }

  before(:each) do
    log_in_user(user)
    create_private_goal(goal)
    click_on goal.title
    click_button "Delete Goal"
  end
  
  scenario "deletes the goal" do
    expect(page).not_to have_content goal.title
  end
end



private

def create_private_goal(goal)
  visit new_goal_url
  fill_in 'Title', :with => goal.title
  fill_in 'Description', :with => goal.description
  choose('No')
  click_on 'Create Goal'
end

def log_in_user(user)
  visit new_session_url
  fill_in 'Username', :with => user.username
  fill_in 'Password', :with => user.password
  click_on 'Sign In'
end

#
#
# feature "the signup process" do
#
#   scenario "has a new user page" do
#     visit new_user_url
#     expect(page).to have_content "New User"
#   end
#
#   feature "signing up a user" do
#
#     before(:each) do
#       visit new_user_url
#       fill_in 'Username', :with => 'david'
#       fill_in 'Password', :with => 'password1'
#       click_button 'Sign Up'
#     end
#
#     scenario "shows username on the user page after signup" do
#       expect(page).to have_content 'david'
#     end
#   end
#
# end
#
# feature "logging in" do
#
#   given(:user) { FactoryGirl.create(:user) }
#
#   before(:each) do
#     log_in_user(user)
#   end
#
#   scenario "shows username on the user page after login" do
#     expect(page).to have_content user.username
#   end
#
# end
