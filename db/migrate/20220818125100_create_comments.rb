# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.string :user_id, null: false
      t.references :commentable, polymorphic: true
      t.timestamps
    end
    add_foreign_key :comments, :users, on_delete: :cascade
  end
end
