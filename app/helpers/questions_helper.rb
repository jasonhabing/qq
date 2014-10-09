module QuestionsHelper


def add_votes_to_question(n, qid)
		question = Question.find(qid)
		users = User.where(:f => true).shuffle
		users[1..n].each do |u|
			question.liked_by u
		end
	end



end
