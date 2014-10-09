module AnswersHelper

def add_votes_to_answer(n, aid)
		answer = Answer.find(aid)
		users = User.where(:f => true).shuffle
		users[1..n].each do |u|
			answer.liked_by u
		end
	end

end
