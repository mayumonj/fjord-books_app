# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.string :user_id, null: false

      t.timestamps
    end
    add_foreign_key :reports, :users, on_delete: :cascade
  end
end
