class User < ApplicationRecord
	include Resonatable
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable,
	:recoverable, :lockable, :timeoutable, :authentication_keys => [:login]

	attr_accessor :login
	mount_uploader :image, ImageUploader
	has_many :create_questions, class_name: "Question", foreign_key: 'created_user_id', dependent: :destroy
	has_and_belongs_to_many :questions
	has_many :records, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :create_contests, class_name: "Contest", foreign_key: 'created_user_id', dependent: :destroy
	has_many :joins
	has_many :contests, through: :joins
	validates :account, presence: true, uniqueness: { case_sensitive: false }
	validates :name, presence: true

	scope :search, -> (search){ where("name LIKE ? ", "%" + search + "%" ) }


	def to_param
		name
	end


	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions).where(["account = :value OR lower(email) = lower(:value)", { :value => login }]).first
		else
			where(conditions).first
		end
	end

	def self.update_rate_rank
		users = User.select(:id, :rate).all.order(rate: :desc)
		rank = 0
		number = 1
		users.size.times do |key|
			if key == 0
				rank += number
			elsif key > 0
				if users[key].rate == users[key - 1].rate
					number += 1
				else
					rank += number
					number = 1
				end
			end
			users[key].update_columns(rate_rank: rank)
		end
	end


	private

	def validate_password?
		password.present? || password_confirmation.present?
	end
end
