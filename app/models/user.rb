# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :following_relationships, class_name: 'Follow',
                                     foreign_key: 'follower_id',
                                     dependent: :destroy,
                                     inverse_of: :follower

  has_many :followed_relationships, class_name: 'Follow',
                                    foreign_key: 'followee_id',
                                    dependent: :destroy,
                                    inverse_of: :followee

  has_many :followees, through: :following_relationships
  has_many :followers, through: :followed_relationships

  def follow?(user)
    !!following_relationships.find_by(followee_id: user.id)
  end

  def follow(user)
    following_relationships.create(followee_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(followee_id: user.id)&.destroy
  end
end
