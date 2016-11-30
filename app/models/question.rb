class Question < ApplicationRecord
	has_many :test_cases
  attr_accessor :i_data, :o_data
  validates :title, presence: true
  validates :content, presence: true
  validates :i_data, presence: true
  validates :o_data, presence: true
end
