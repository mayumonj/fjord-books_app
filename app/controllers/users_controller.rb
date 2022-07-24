# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  # GET user/:user_id/followees
  def followees
    @followees = User.find_by(id: params[:id]).followees
  end

  # GET user/:user_id/followers
  def followers
    @followers = User.find_by(id: params[:id]).followers
  end
end
