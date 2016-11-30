class JudgeSystem < ApplicationRecord
  attr_accessor :ans, :question_id
  validates :ans, presence: true
  validates :question_id, inclusion:{ in: "" }
end
