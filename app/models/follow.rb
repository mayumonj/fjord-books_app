# frozen_string_literal: true

class Follow < ApplicationRecord
  validates :followee_id, :follower_id, presence: true
  validates :followee_id, uniqueness: { scope: :follower_id }
  belongs_to :followee, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
