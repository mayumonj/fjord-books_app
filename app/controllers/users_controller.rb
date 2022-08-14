# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show followees followers]

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show; end

  def followees
    @followees = @user.followees
  end

  def followers
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
