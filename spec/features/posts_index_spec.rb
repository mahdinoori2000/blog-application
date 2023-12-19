require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                         post_counter: 0)
    @first_post = Post.create(author: @user1, title: 'Post 1', text: 'This is my first post', like_counter: 0,
                              comment_counter: 0)
    @comment1 = Comment.create(user: @user1, post: @first_post, text: 'Hi Tom Wonderful!')
    visit "/users/#{@user1.id}/posts"
  end

  it "should displays the user's profile picture" do
    expect(page).to have_css("img[src*='https://unsplash.com/photos']")
  end

  it 'should displays the username' do
    expect(page).to have_content(@user1.name)
  end

  it 'should displays the number of posts the user has written' do
    expect(page).to have_content(@user1.post_counter)
  end

  it "should displays a post's title" do
    expect(page).to have_content(@first_post.title)
  end

  it "should displays some of the post's body" do
    expect(page).to have_content(@first_post.text)
  end

  it 'should displays the first comments on a post' do
    expect(page).to have_content(@comment1.text)
  end

  it 'should displays how many comments a post has' do
    expect(page).to have_content(@first_post.comment_counter)
  end

  it 'should displays how many likes a post has' do
    expect(page).to have_content(@first_post.like_counter)
  end

  it 'should displays a section for pagination if there are more posts than fit on the view' do
    10.times do
      Post.create(author: @user1, title: 'Sample Post', text: 'This is a sample post')
    end
    visit user_posts_path(@user1)
    expect(page).to have_link('Pagination')
  end
end
