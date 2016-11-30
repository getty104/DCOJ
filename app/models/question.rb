class Question < ApplicationRecord
	belongs_to :user
  attr_accessor :i_data, :o_data
  validates :title, presence: true
  validates :content, presence: true
  validates :input, presence: true
  validates :output, presence: true
end
