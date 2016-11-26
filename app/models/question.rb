class Question < ApplicationRecord
	has_many :test_cases
  attr_accessor :input, :output
end
