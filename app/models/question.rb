class Question < ApplicationRecord
	has_many :test_cases
  attr_accessor :i_data, :o_data
end
