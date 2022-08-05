# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    followee = User.find_by(id: params[:relationship]&.[](:followee_id))
    if followee
      begin
        current_user.following_relationships.create!(followee: followee)
      rescue StandardError
        flash[:error] = t('relationship.follow_failed')
      end
      redirect_to followee
    else
      flash[:error] = t('relationship.user_not_found')
      redirect_to users_path
    end
  end

  def destroy
    begin
      Relationship.find_by(followee_id: params[:followee_id], follower_id: current_user.id)&.destroy!
    rescue StandardError
      flash[:error] = t('relationship.unfollow_failed')
    end
    redirect_to user_path(params[:followee_id])
  end
end
