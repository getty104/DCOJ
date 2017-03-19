class Join < ApplicationRecord
	belongs_to :contest
	belongs_to :user

	def update_status question_level
		solve_time = "level#{question_level}_solve_time"
		update_columns( score: score + 100 * question_level, amount_time: amount_time +
			(Time.now - contest.start_time).to_i, solve_time => (Time.now - contest.start_time).to_i )
	end
end
