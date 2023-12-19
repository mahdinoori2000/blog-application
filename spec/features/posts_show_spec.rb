require 'rails_helper'

RSpec.describe 'Post show Page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                         post_counter: 0)
    @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', like_counter: 0,
                              comment_counter: 0)
    @comment1 = Comment.create(post: @first_post, user: @user1, text: 'Hi Tom!, Nice comment')
    visit "/users/#{@user1.id}/posts/#{@first_post.id}"
  end

  it 'should displays the post title' do
    expect(page).to have_content(@first_post.title)
  end

  it 'should displays who author of the post' do
    expect(page).to have_content(@first_post.author.name)
  end

  it 'should displays how many comments it has' do
    expect(page).to have_content(@first_post.comment_counter)
  end

  it 'should displays how many likes it has' do
    expect(page).to have_content(@first_post.like_counter)
  end

  it 'should displays the post body' do
    expect(page.html).to include(@first_post.text)
  end

  it 'should displays the username of  commentor' do
    expect(page).to have_content(@comment1.user.name)
  end
end
