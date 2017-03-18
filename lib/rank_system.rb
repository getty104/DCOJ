module RankSystem
	def update_ranking(contest)
		joins = contest.joins.select(:id, :score, :amount_time).order(score: :desc, amount_time: :asc)
		rank = 0
		number = 1
		joins.size.times do |key|
			if key == 0
				rank += number
			elsif key > 0
				if joins[key].score == joins[key - 1].score && joins[key].amount_time == joins[key - 1].amount_time
					number += 1
				else
					rank += number
					number = 1
				end
			end
			joins[key].update_columns(rank: rank)
		end
	end
module_function :update_ranking
end