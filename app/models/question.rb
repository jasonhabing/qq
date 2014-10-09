class Question < ActiveRecord::Base

	extend FriendlyId
	friendly_id :content, use: :slugged


	acts_as_votable
	belongs_to :user
	has_many :answers
	

  def self.highest_voted
    self.order("cached_votes_score DESC")
  end



end
