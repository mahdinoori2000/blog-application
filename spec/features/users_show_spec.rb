require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                         post_counter: 0)
    @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', like_counter: 0,
                              comment_counter: 0)
    @second_post = Post.create(author: @user1, title: 'post2', text: 'This is my second post', like_counter: 0,
                               comment_counter: 0)
    @third_post = Post.create(author: @user1, title: 'post3', text: 'This is my third post', like_counter: 0,
                              comment_counter: 0)
    @fourth_post = Post.create(author: @user1, title: 'post4', text: 'This is my fourth post', like_counter: 0,
                               comment_counter: 0)
    visit "/users/#{@user1.id}"
  end

  it "should displays the user's profile picture" do
    expect(page).to have_css("img[src*='#{@user1.photo}']")
  end

  it 'should displays the username' do
    expect(page).to have_content(@user1.name)
  end

  it 'should displays the number of posts ' do
    expect(page).to have_content(@user1.post_counter)
  end

  it "should displays the user's bio" do
    expect(page).to have_content(@user1.bio)
  end

  it 'should displays the first 3 posts' do
    post_elements = all('#post-card')
    expect(post_elements.count).to eq(3)
  end

  it "should display a button that let view all of a user's posts." do
    expect(page).to have_link('See All Posts')
  end

  it "redirects to a user's post index page when 'View All Posts' button is clicked" do
    click_link 'See All Posts'
    expect(page).to have_current_path(user_posts_path(@user1))
  end

  it "redirects to a user's post show page when clicking a post" do
    click_link 'post4'
    expect(page).to have_current_path(user_post_path(@user1, @fourth_post))
  end
end
