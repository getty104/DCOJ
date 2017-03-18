class Question < ApplicationRecord
	attr_accessor :i_data, :o_data
	mount_uploader :image, ImageUploader
	belongs_to :created_user, class_name: "User", foreign_key: 'created_user_id'
	has_and_belongs_to_many :users 
	has_many :records, dependent: :destroy
	has_many :posts, dependent: :destroy
	validates :title, presence: true
	validates :content, presence: true
	validates :input, presence: true
	validates :output, presence: true
	validates :question_level, presence: true
	validates :input_text, presence: true
	validates :output_text, presence: true
	validates :sample_input, presence: true
	validates :sample_output, presence: true

	scope :search, -> (search){ where("title LIKE ?", "%" + search + "%" ).where(for_contest: 0)  }
end
