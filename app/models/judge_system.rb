class JudgeSystem < ApplicationRecord
	attr_accessor :ans, :question_id, :evaluation, :first_time
	validates :ans, presence: true

	def self.update_info
		contests = Contest.where(contest_end: false).where("finish_time < ?", Time.now).includes(:users).includes(:questions)
		contests.each do |contest|
			contest.users.each do |user|
				
			end

			contest.questions.each do |question|
				question.update_attribute(:for_contest, 0)
			end
			contest.update_attribute(:contest_end, true)
		end
	end
	
end
