require 'rails_helper'
RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'Sam', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/256/User-icon.png',
                         bio: 'Teacher from Poland.', post_counter: 1)
    @user2 = User.create(name: 'John', photo: 'https://example.com/user2.jpg', bio: 'Developer from USA.',
                         post_counter: 3)
    visit root_path
  end

  it 'should displays the username of all users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'should displays the profile picture for each user' do
    expect(@user1.photo).to be_present
    expect(@user2.photo).to be_present
  end

  it 'should displays the number of posts for each user' do
    expect(page).to have_content(@user1.post_counter)
    expect(page).to have_content(@user2.post_counter)
  end

  it "should redirects to a user's show page when clicked on the name" do
    click_link @user1.name
    expect(page).to have_current_path(user_path(@user1))

    visit root_path
    click_link @user2.name
    expect(page).to have_current_path(user_path(@user2))
  end
end
