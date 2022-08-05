# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :followee, foreign_key: { to_table: :users }, on_delete: :cascade
      t.references :follower, foreign_key: { to_table: :users }, on_delete: :cascade
    end
    add_index :relationships, %i[followee_id follower_id], unique: true
  end
end
