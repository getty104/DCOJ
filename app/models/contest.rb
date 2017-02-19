class Contest < ApplicationRecord
	attr_accessor :contest_length, :level1_question, :level2_question, :level3_question, :level4_question, :level5_question, :join_account, :unjoin_account
	belongs_to :created_user, class_name: "User", foreign_key: 'created_user_id'
	has_many :questions
	has_many :joins
	has_many :users, through: :joins
	has_many :posts, dependent: :destroy
end
