module ApplicationHelper
	
# calculate distance between two points using Euclidean n-distance algorithm	
	def distance(p1, p2)
		c = p1.count
		t = 0
		c.times do 	|n|
			e = (p1[n] - p2[n]) ** 2
			t = t + e		
		end	
		t = Math.sqrt(t)
	end

# createx and output vectors as array by comparing each question to all other questions
	def create_post_vectors
		@questions = Question.all
		@words = @questions.map do |q|
			q.content.split(' ')
		end.flatten.uniq
		@vectors = @questions.map do |q|
			@words.map do |w|
				q.content.include?(w) ? 1 : 0
			end
		end
	end

#calculate which vectors are furthest apart
	def furthest_vectors	
		@vectors = create_post_vectors
		puts "vectors are #{@vectors}"		
		or_d = 0
		vec1 = []
		vec2 = []
		@vectors.each do |v|
			puts "v is #{v}"
			@vectors.each do |v2|
				puts "v2 is #{v2}"
				puts "comparing #{v} to #{v2}"
				d = distance(v, v2)
				puts "distance computed as #{d}"
				if d > or_d
					or_d = d
					vec1 = v
					vec2 = v2
				end
			end
		end
		puts "the furthest distance is between #{vec1} and #{vec2} at #{or_d}"
	end


end
