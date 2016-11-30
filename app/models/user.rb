class User < ApplicationRecord
	has_many :codes
	has_secure_password
  validates :account, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  attr_accessor :remember_token
 # 与えられた文字列のハッシュ値を返す
 def User.digest(string)
 	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
 	BCrypt::Engine.cost
 	BCrypt::Password.create(string, cost: cost)
 end

  # ランダムなトークンを返す
  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

   # ユーザーログインを破棄する
   def forget
   	update_attribute(:remember_digest, nil)
   end
 end
