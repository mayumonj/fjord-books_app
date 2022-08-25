# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  validates :title, :text, :user_id, presence: true
  has_many :comments, as: :commentable, dependent: :destroy
end
