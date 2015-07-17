class AddDownvoteToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :downvote, :integer, default: 0
  end
end
