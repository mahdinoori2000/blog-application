class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_comments_counter_after_save
  before_destroy :update_comments_counter_before_destroy

  private

  def update_comments_counter_after_save
    post.increment!(:comment_counter)
  end

  def update_comments_counter_before_destroy
    post.decrement!(:comment_counter)
  end
end
