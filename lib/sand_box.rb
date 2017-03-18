# -*- encoding: UTF-8 -*-
require "net/http"
require "uri"
require "json"
require "thor"
require 'timeout'

module Wandbox module Web
	def list
		res = Net::HTTP.get_response URI.parse('http://melpon.org/wandbox/api/list.json')
		if res.code != "200"
			return []
		end
		JSON.parse(res.body)
	end
	module_function :list

	def compile compiler: "", code: "", codes: [], options: "", stdin: "", compiler_option_raw: "", runtime_option_raw: "", save: false
		body = {
			"code" => code,
			"compiler" => compiler,
			"codes" => codes,
			"options" => options,
			"stdin" => stdin,
			"compiler-option-raw" => compiler_option_raw,
			"runtime-option-raw" => runtime_option_raw,
			"save" => save,
		}

		uri = URI.parse("http://melpon.org/wandbox/api/compile.json")

		request = Net::HTTP::Post.new(uri.request_uri, initheader = { "Content-type" => "application/json" },)
		request.body = body.to_json
		http = Net::HTTP.new(uri.host, uri.port)

		
		http.start do |http|
			response = http.request(request)
			JSON.parse(response.body)
		end

		
	end
	module_function :compile
end
end

module Wandbox
	def run compiler, code, stdin, time
		data = nil
		begin
			Timeout::timeout(time) do
				data = Web.compile({compiler: compiler, code: code, stdin: stdin})
			end
		rescue Timeout::Error => e
			return 'TLE'
		rescue => e
			return 'RE'
		end
		#binding.pry
		if data["status"].to_i == 0
			return data["program_output"].gsub(/\R/, "\n") 
		else
			return 'RE'
		end
	end
	
	module_function :run
end








