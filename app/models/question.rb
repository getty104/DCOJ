class Question < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :created_user, class_name: "User", foreign_key: 'created_user_id'
	has_and_belongs_to_many :users 
	has_many :records, dependent: :destroy
	has_many :posts, dependent: :destroy
	attr_accessor :i_data, :o_data
	validates :title, presence: true
	validates :content, presence: true
	validates :input, presence: true
	validates :output, presence: true
	validates :question_level, presence: true
	validates :input_text, presence: true
	validates :output_text, presence: true
	validates :sample_input, presence: true
	validates :sample_output, presence: true

	def self.search(search) #self.でクラスメソッドとしている
		if search && search != "" # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
			Question.where("title like ?", search ).where(for_contest: false) 
		else
			Question.where(title: search)
		end
	end
end
