class Contest < ApplicationRecord
	belongs_to :user
	has_many :questions
	has_many :join_users, class_name: "User", foreign_key: 'joined_contest_id'

end
