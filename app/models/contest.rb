require "#{Rails.root}/lib/rate_system.rb"
class Contest < ApplicationRecord
	attr_accessor :contest_length, :level1_question, :level2_question, :level3_question, :level4_question, :level5_question, :join_account, :unjoin_account
	belongs_to :created_user, class_name: "User", foreign_key: 'created_user_id'
	has_many :questions
	has_many :joins
	has_many :users, through: :joins
	has_many :posts, dependent: :destroy
	validates :title, presence: true
	validates :description, presence: true

	scope :future_contests, -> (){ where("start_time > ?", Time.now) }
	scope :now_contests, -> (){ where("start_time <= ?", Time.now).where("finish_time > ?", Time.now) }
	scope :end_contests, -> (){ where("finish_time < ?", Time.now) }
	scope :not_change_to_end_contests, ->(){ end_contests.where( contest_end: false ).order( start_time: :asc ) }

	def self.update_info
		Contest.not_change_to_end_contests.each do |contest|
			RateSystem.change_rating( contest.joins )
			contest.update_attribute(:contest_end, true )
		end
	end

end
