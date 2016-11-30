class Question < ApplicationRecord
	belongs_to :user
  has_and_belongs_to_many :solved_users, class_name: "User"
  attr_accessor :i_data, :o_data
  validates :title, presence: true
  validates :content, presence: true
  validates :input, presence: true
  validates :output, presence: true
end
