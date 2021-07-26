# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[show create edit update destroy]
  # GET /answers or /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1 or /answers/1.json
  def show; end

  # GET /answers/new
  def new
    @answer = @question.answer.new
  end

  # GET /answers/1/edit
  def edit
    @answer = @question.answers.find_by(id: params[:id])
  end

  # POST /answers or /answers.json
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user_id = if current_user.present?
                        current_user.id
                      else
                        create_guest_user.id
                      end
    respond_to do |format|
      if @answer.save
        AnswerMailer.with(id: @answer.id).new_answer_email.deliver_later
        format.html { redirect_to question_path(@answer.question_id), notice: 'Answer was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @question.answers.update(answer_params)

        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @question.answers.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.permit(:title, :question_id)
  end
end
