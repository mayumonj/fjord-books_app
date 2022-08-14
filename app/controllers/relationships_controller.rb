# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    followee = User.find_by(id: params.dig(:relationship, :followee_id))
    if followee
      current_user.following_relationships.create!(followee: followee) unless current_user.follow?(followee)
      redirect_to followee
    else
      flash[:error] = t('relationship.user_not_found')
      redirect_to users_path
    end
  end

  def destroy
    Relationship.find_by(followee_id: params[:followee_id], follower_id: current_user.id)&.destroy!
    redirect_to user_path(params[:followee_id])
  end
end
