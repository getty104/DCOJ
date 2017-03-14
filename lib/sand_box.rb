require 'timeout'
require 'open3'
class SandBox
	def self.run(submit_code, input_file, ans_file, time, lang,id)
		result_or_error = nil
		begin
			#input_data = File.read(input_file)
			#output_data = nil
			#error_data = nil
			#status = nil
			#Timeout::timeout time do
				result_or_error =	Thread.new do
				if Rails.env == "development"
					case lang.to_s
					when "c"
						system "gcc -o ./tmp/judge/#{id}_out #{submit_code}"
						#$SAFE = 1
						system"./tmp/judge/./#{id}_out < #{input_file} > #{ans_file}"#, pgroup: true, rlimit_core: 1, rlimit_cpu: 10, rlimit_as: 10*(10 ** 8), rlimit_nofile: 4
						#Process.wait2
						#output_data, error_data, status = Open3.capture3 "./tmp/judge/./#{id}_out", :stdin_data => input_data
					when "c++"
						system "g++ -o ./tmp/judge//#{id}_out #{submit_code} -O2"
						#$SAFE = 1
						system "./tmp/judge/./#{id}_out < #{input_file} > #{ans_file}"#, pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "./tmp/judge/./#{id}_out", :stdin_data => input_data
					when "java"
						system "javac #{submit_code}"
						#$SAFE = 1
						system "java #{submit_code.split('.java')[0]} < #{input_file} > #{ans_file}"#, pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "java #{submit_code.split('.java')[0]}", :stdin_data => input_data
					when "ruby"
						#$SAFE = 1
						system "ruby #{submit_code} < #{input_file} > #{ans_file}"#, pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "ruby #{submit_code}", :stdin_data => input_data
					end
				else
					case lang.to_s
					when "c"
						system "gcc -o /tmp/#{id}_out #{submit_code}"
						#$SAFE = 1
						system"/tmp/./#{id}_out < #{input_file} > #{ans_file}", pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "./tmp/judge/./#{id}_out", :stdin_data => input_data
					when "c++"
						system "g++ -o /tmp/#{id}_out #{submit_code} -O2"
						#$SAFE = 1
						system "/tmp/./#{id}_out < #{input_file} > #{ans_file}", pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "./tmp/judge/./#{id}_out", :stdin_data => input_data
					when "java"
						system "javac #{submit_code}"
						#$SAFE = 1
						system "java #{submit_code.split('.java')[0]} < #{input_file} > #{ans_file}", pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "java #{submit_code.split('.java')[0]}", :stdin_data => input_data
					when "ruby"
						#$SAFE = 1
						system "ruby #{submit_code} < #{input_file} > #{ans_file}", pgroup: true, rlimit_core: 1, rlimit_cpu: 8, rlimit_as: 10*(10 ** 6), rlimit_nofile: 0
						#output_data, error_data, status = Open3.capture3 "ruby #{submit_code}", :stdin_data => input_data
					end
				end
			end.value
		#end
			#if status.success?
			#	result_or_error = true
			#else
			#	result_or_error = error_data
			#end
		rescue StandardError, SecurityError, Timeout::Error => e
			result_or_error = e
		end
		#binding.pry
		return result_or_error
	end
end