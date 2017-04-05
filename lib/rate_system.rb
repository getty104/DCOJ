
module RateSystem
	def arc_gauss(x)
		return ( -0.5 * ( Math.log( 1 - x ** 2 ) ) ) ** ( Math::PI / 2 )
	end

	def change_rating(joins)
		numofcoder = joins.size.to_i
		return nil if numofcoder < 2 

		averating = 0
		joins.each do |join|
			averating += join.user.rate
		end
		averating /= numofcoder

		competition_factor_sum1, competition_factor_sum2 = 0, 0
		joins.each do |join|
			competition_factor_sum1 += join.user.volatility ** 2
			competition_factor_sum2 += (join.user.rate - averating) ** 2
		end
		competition_factor = Math.sqrt(competition_factor_sum1 / numofcoder + competition_factor_sum2/(numofcoder - 1))

		newrate = []
		newvolatility = []
		numofcoder.times do |key1|
			erank = 0.5
			oldrate = joins[key1].user.rate
			oldvolatility = joins[key1].user.volatility

			numofcoder.times do |key2|
				erank += 0.5 * ( Math.erf( ( oldrate - joins[key2].user.rate ) / ( Math.sqrt( 2 * (oldvolatility ** 2 + joins[key2].user.volatility ** 2) ) ) ) + 1 )
			end

			eperf = - arc_gauss( ( erank - 0.5 ) / numofcoder )
			aperf = - arc_gauss( ( joins[key1].rank - 0.5 ) / numofcoder )
			perfas = joins[key1].user.rate + competition_factor*(aperf-eperf)
			weight = (1 / (1 - ((0.42 / (joins[key1].user.joins.size.to_i + 1)) + 0.18))) - 1
			capacity = 150 + 1500 / ( joins[key1].user.joins.size.to_i + 2 )
			newrate << ( oldrate + weight * perfas ) / ( 1 + weight )
			newvolatility << Math.sqrt( ( newrate[key1] - oldrate ) ** 2 / weight + oldvolatility ** 2 / ( weight + 1 ) )
		end
		numofcoder.times do |key|
			joins[key].user.update_columns( rate: newrate[key], volatility: newvolatility[key].round(3) )
		end
	end
	
	module_function :change_rating, :arc_gauss
end