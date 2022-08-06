# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page])
    @pages = User.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
end
