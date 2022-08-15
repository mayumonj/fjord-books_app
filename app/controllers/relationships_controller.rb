# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    followee = User.find_by(id: params.dig(:relationship, :followee_id))
    relationship = current_user.following_relationships.find_or_initialize_by(followee: followee)

    if relationship.save
      redirect_to followee
    else
      flash[:error] = t('relationship.follow_failed')
      redirect_to users_path
    end
  end

  def destroy
    Relationship.find_by(followee_id: params[:followee_id], follower_id: current_user.id)&.destroy!
    redirect_to user_path(params[:followee_id])
  end
end
