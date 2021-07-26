# frozen_string_literal: true

class AnswerMailer < ApplicationMailer
  def new_answer_email
    @answer = Answer.find(params[:id])
    mail(to: @answer.question.user.email, subject: 'You got a new order!')
  end
end
