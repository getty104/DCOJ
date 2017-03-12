require 'timeout'

class SandBox
	def self.run(submit_code, input_file, ans_file, time, lang,id)
		result_or_error = nil
		begin
			Timeout::timeout time do
				result_or_error = Thread.new do
					case lang.to_s
					when "c"
						system "gcc -o #{id}_out #{submit_code}"
						$SAFE = 1
						system "./#{id}_out < #{input_file} > #{ans_file}"
					when "c++"
						system "g++ -o #{id}_out #{submit_code} "
						$SAFE = 1
						system "./#{id}_out < #{input_file} > #{ans_file}"
					when "java"
						system "javac #{submit_code}"
						$SAFE = 1
						system "java #{submit_code.split('.java')[0]} < #{input_file} > #{ans_file}"
					when "ruby"
						$SAFE = 1
						system "ruby #{submit_code} < #{input_file} > #{ans_file}"
					end
				end.value
			end
		rescue StandardError, SecurityError, Timeout::Error => e
			result_or_error = e
		end
		return result_or_error
	end
end