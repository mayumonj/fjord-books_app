# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :followee, class_name: 'User', inverse_of: :followed_relationships
  belongs_to :follower, class_name: 'User', inverse_of: :following_relationships
  validates :followee_id, uniqueness: { scope: :follower_id }
end
