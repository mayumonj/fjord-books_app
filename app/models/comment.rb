# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :text, :user_id, :commentable_id, :commentable_type, presence: true
end
