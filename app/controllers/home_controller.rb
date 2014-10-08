class HomeController < ApplicationController
  def show

  	unless current_user.nil?
  		@user = current_user
  		@userquestions = @user.questions	
  	end

  	@questions = Question.all

  end
end
