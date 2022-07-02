# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  def follow?(user)
    !!Follow.find_by(followee_id: id, follower_id: user.id)
  end

  def count_followees
    Follow.group(:followee_id).count[id] || 0
  end

  def count_followers
    Follow.group(:follower_id).count[id] || 0
  end

  def followees
    follower_ids = Follow.where(followee_id: id).map(&:follower_id)
    User.order(:id).find(follower_ids)
  end

  def followers
    followee_ids = Follow.where(follower_id: id).map(&:followee_id)
    User.order(:id).find(followee_ids)
  end
end
