# frozen_string_literal: true

class FollowsController < ApplicationController
  # POST /follows
  def create
    user = User.find(params[:follow][:followee_id])
    current_user.follow(user)
    redirect_to user
  end

  # DELETE /follows/:id
  def destroy
    user = Follow.find(params[:id]).followee
    current_user.unfollow(user)
    redirect_to user
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: users_path)
  end

  private

  def follow_params
    params.require(:follow).permit(:followee_id, :follower_id)
  end
end
