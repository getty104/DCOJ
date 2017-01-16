class JudgeSystem < ApplicationRecord
	attr_accessor :ans, :question_id, :evaluation, :first_time
	validates :ans, presence: true
end
