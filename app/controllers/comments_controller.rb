# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  def create
    comment = Comment.new(comment_params)
    comment.commentable = commentable(*(request.path.split('/')[1, 2]))
    comment.user = current_user
    begin
      comment.save!
      redirect_to comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    rescue StandardError => e
      redirect_to comment.commentable, notice: e.message
    end
  end

  def destroy
    if current_user == @comment.user
      @comment.destroy!
      redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render403
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def commentable(type, id)
    case type
    when 'books' then Book.find(id)
    when 'reports' then Report.find(id)
    end
  end

  def comment_params
    params.permit(:text)
  end
end
