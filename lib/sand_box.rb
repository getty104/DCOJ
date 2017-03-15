require 'timeout'
class SandBox
	def self.run(submit_code, input_file, ans_file, time )
		result_or_error = nil
		begin

			Timeout::timeout time do
				result_or_error =	system"wandbox run #{submit_code} < #{input_file} > #{ans_file}"
			end
		rescue StandardError, SecurityError, Timeout::Error => e
			result_or_error = e
		end
		return result_or_error
	end
end