class QuestionsController < ApplicationController
	def index
		@questions = Question.all
	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers
	end

	def search_question
		@question_lists = Question.where(['title LIKE ?', "%#{params[:search]}%"])
	end

	def answers
		@question = Question.find(params["id"])
		@answers = @question.answers
		render partial: "/questions/answers", :locals => {:question => @question, :answers => @answers}
	end
end
