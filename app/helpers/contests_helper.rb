module ContestsHelper
	def solve_time(time)
		hour = time / (60 * 60)
		time = time % (60 * 60)
		minute = time / 60
		sec = time % 60
		return "#{hour}:#{minute}:#{sec}"
	end

	def arc_gauss(x)
		return (-0.5*(Math.log(1-x**2)))**(Math.PI/2)
	end
end
