class AddUpvoteToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :upvote, :integer, default: 0
  end
end
