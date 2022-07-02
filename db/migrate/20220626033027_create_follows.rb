# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :followee, foreign_key: { to_table: :users }, on_delete: :cascade
      t.references :follower, foreign_key: { to_table: :users }, on_delete: :cascade

      t.index %i[followee_id follower_id], unique: true
    end
  end
end
