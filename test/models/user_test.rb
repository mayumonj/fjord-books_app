# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#following?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    Relationship.create!(following: bob, follower: alice)
    assert alice.following?(bob)
  end

  test '#followed_by?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not bob.followed_by?(alice)
    Relationship.create!(following: bob, follower: alice)
    assert bob.followed_by?(alice)
  end

  test '#follow' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    alice.follow(bob)
    assert alice.following?(bob)
  end

  test '#unfollow' do
    alice = users(:alice)
    bob = users(:bob)

    alice.unfollow(bob)
    assert_not alice.following?(bob)

    alice.follow(bob)
    assert alice.following?(bob)

    alice.unfollow(bob)
    assert_not alice.following?(bob)
  end

  test '#name_or_email' do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end
end
