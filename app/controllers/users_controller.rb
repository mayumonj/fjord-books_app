# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.target_user(params)
  end

  def followees
    @user = User.target_user(params)
    @followees = @user.followees
  end

  def followers
    @user = User.target_user(params)
    @followers = @user.followers
  end
end
