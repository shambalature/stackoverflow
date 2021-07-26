# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
end
