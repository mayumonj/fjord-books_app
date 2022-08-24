# frozen_string_literal: true

class CommentsController < ApplicationController
  # before_action :set_commentable
  # before_action :set_comment, only: %i[show edit update destroy]

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

  private

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
