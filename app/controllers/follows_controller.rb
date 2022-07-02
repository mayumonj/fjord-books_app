# frozen_string_literal: true

class FollowsController < ApplicationController
  # GET user/:user_id/followees
  def followees
    @followees = User.find_by(id: params[:user_id]).followees
  end

  # GET user/:user_id/followers
  def followers
    @followers = User.find_by(id: params[:user_id]).followers
  end

  # POST /follows/:followee_id
  def create
    follow = Follow.new(followee_id: current_user.id, follower_id: params[:followee_id])
    respond_to do |format|
      if follow.save
        format.html { redirect_to user_path(params[:followee_id]), notice: t('follow.follow_message', name: Follow.model_name.human) }
      else
        format.html { redirect_to user_path(params[:followee_id]), notice: t('errors.template.header.one', model: Follow.model_name.human) }
      end
    end
  end

  # DELETE /follows/:followee_id
  def destroy
    follow = Follow.find_by(followee_id: current_user.id, follower_id: params[:followee_id])
    respond_to do |format|
      if follow.destroy
        format.html { redirect_to user_path(params[:followee_id]), notice: t('follow.unfollow_message', name: Follow.model_name.human) }
      else
        format.html { redirect_to user_path(params[:followee_id]), notice: t('errors.template.header.one', name: Follow.model_name.human) }
      end
    end
  end

  private

  def follow_params
    params.require(:follow).permit(:followee_id, :follower_id)
  end
end
