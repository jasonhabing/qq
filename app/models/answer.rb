class Answer < ActiveRecord::Base

	acts_as_votable
	validates :content, length: { maximum: 140 }
	belongs_to :questions, dependent: :destroy
	belongs_to :user

	def self.highest_voted
    self.order("cached_votes_score DESC")
  	end

end
