class Contest < ApplicationRecord
	attr_accessor :contest_length, :level1_question, :level2_question, :level3_question, :level4_question, :level5_question, :join_account, :unjoin_account
	belongs_to :created_user, class_name: "User", foreign_key: 'created_user_id'
	has_many :questions
	has_many :joins
	has_many :users, through: :joins
	has_many :posts, dependent: :destroy
	validates :title, presence: true
	validates :description, presence: true
	def self.future_contests
		Contest.where("start_time > ?", Time.now)
	end

	def self.now_contests
		Contest.where("start_time <= ?", Time.now).where("finish_time > ?", Time.now)
	end

	def self.end_contests
		Contest.where("finish_time < ?", Time.now)
	end

	private

	def arc_gauss(x)
		return (-0.5*(Math.log(1-x**2)))**(Math::PI/2)
	end

	public 

	def change_rating
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
			competition_factor_sum2 +=(join.user.rate - averating) ** 2
		end
		competition_factor = (competition_factor_sum1 / numofcoder + competition_factor_sum2/(numofcoder - 1)) ** 0.5

		newrate = []
		newvolatility = []
		numofcoder.times do |key1|
			erank = 0.5
			oldrate = joins[key1].user.rate
			oldvolatility = joins[key1].user.volatility

			numofcoder.times do |key2|
				erank+=0.5*(Math.erf((oldrate - joins[key2].user.rate)/((2*(oldvolatility ** 2 + joins[key2].user.volatility ** 2)) ** 0.5)) + 1)
			end

			eperf = - arc_gauss( ( erank - 0.5 ) / numofcoder )
			aperf = - arc_gauss( ( joins[key1].rank - 0.5 ) / numofcoder )
			perfas = joins[key1].user.rate + competition_factor*(aperf-eperf)
			weight = (1 / (1 - ((0.42 / (joins[key1].user.joins.size.to_i + 1)) + 0.18))) - 1
			capacity = 150 + 1500 / ( joins[key1].user.joins.size.to_i + 2 )
			newrate << (oldrate + weight * perfas) / ( 1 + weight )
			newvolatility << ((newrate[key1] - oldrate)**2/weight + oldvolatility**2/(weight + 1)) ** 0.5
		end
		numofcoder.times do |key|
			joins[key].user.update_columns(rate: newrate[key],volatility: newvolatility[key].round(3))
		end
	end

	def self.update_info
		Contest.end_contests.where( contest_end: false ).each do |contest|
			contest.change_rating
			contest.update_attribute(:contest_end, true )
		end
	end

end
