# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def sanitize_title
    ActionView::Base.full_sanitizer.sanitize(title)
  end
end
