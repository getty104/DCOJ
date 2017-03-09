module ContestsHelper
	def solve_time(time)
		hour = time / (60 * 60)
		time = time % (60 * 60)
		minute = time / 60
		sec = time % 60
		return sprintf("%02d:%02d:%02d",hour,minute,sec)
	end

end
