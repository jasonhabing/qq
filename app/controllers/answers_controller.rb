  class AnswersController < ApplicationController
  
  include AnswersHelper
  
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  def upvote
    @question = Question.find(params[:qid])
    @answer = Answer.find(params[:id])
    @answer.liked_by current_user
    @a_id = @answer.id
    @count = @answer.get_upvotes.size 
    respond_to do |format|
    format.html {redirect_to :back }
    format.json { render json: { count: @question.liked_count } }
    format.js 
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show

  end

  def add_votes
    v = params[:votes].to_i
    aid = params[:aid].to_i
    add_votes_to_answer(v,aid)
    @question = Answer.find(aid).question
    redirect_to @question

  end

  # GET /answers/new
  def new
    @answer = Answer.new
    @qid = params[:q]
    @question = Question.where(:id => @qid).first
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    
    if @answer.user_id.nil?
    @answer.user_id = current_user.id
    end

    respond_to do |format|
      if @answer.save
        @question = @answer.question
        format.html { redirect_to "/questions/#{@question.slug}", notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id, :votes)
    end
end
