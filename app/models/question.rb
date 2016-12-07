class Question < ApplicationRecord
	belongs_to :created_user, class_name: "User", :foreign_key => 'created_user_id'
  has_and_belongs_to_many :users 
  has_many :records, dependent: :destroy
  attr_accessor :i_data, :o_data
  validates :title, presence: true
  validates :content, presence: true
  validates :input, presence: true
  validates :output, presence: true
end
