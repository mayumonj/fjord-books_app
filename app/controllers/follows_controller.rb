# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    followee = User.find(params[:follow][:followee_id])
    redirect_to followee if current_user.following_relationships.create(followee: followee)
  end

  def destroy
    followee = User.find(params[:followee_id])
    current_user.following_relationships.find_by(followee: followee)&.destroy
    redirect_to followee
    # redirect_to followee if current_user.following_relationships.find_by(followee: followee)&.destroy
    # にすると、204で画面が更新されない
    # No template found for FollowsController#destroy, rendering head :no_content
    # Completed 204 No Content in 7ms (ActiveRecord: 0.3ms | Allocations: 2976)
  end
end
