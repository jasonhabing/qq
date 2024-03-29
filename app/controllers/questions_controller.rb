class QuestionsController < ApplicationController
  include QuestionsHelper

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show

    @question = Question.friendly.find(params[:id])
    @answers = @question.answers.highest_voted
    @title = @question.content
    @first_answer = @question.answers.highest_voted.first
    if @first_answer.nil?
      @description = "Be the first to answer the question #{@question.content}."
    else
      @description = @first_answer.content
    end
    @author = @question.user.username

  end


  def upvote
    @question = Question.find(params[:id])
    @question.liked_by current_user
    redirect_to @question
  end


  # GET /questions/new
  def new
    @question = Question.new
  end

  def upvote
    
  end

  def add_votes
    v = params[:votes].to_i
    qid = params[:qid].to_i
    add_votes_to_question(v,qid)
    @question = Question.find(qid)
    redirect_to @question
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    
    if @question.user_id.nil?
    @question.user_id = current_user.id
    end

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :user_id, :topic_id, :votes)
    end
end
