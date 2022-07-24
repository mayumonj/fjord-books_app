# frozen_string_literal: true

class AddUniqueIndexToFollow < ActiveRecord::Migration[6.1]
  def change
    add_index :follows, %i[followee_id follower_id], unique: true
  end
end
