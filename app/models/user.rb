class User < ApplicationRecord
  include Resonatable
  mount_uploader :image, ImageUploader
  has_many :create_questions, class_name: "Question", foreign_key: 'created_user_id', dependent: :destroy
  has_and_belongs_to_many :questions
  has_many :records, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :contests, dependent: :destroy
  has_secure_password
  validates :account, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password,
  :length => { :minimum => 6, :if => :validate_password? },
  :confirmation => { :if => :validate_password? }
  attr_accessor :remember_token
#to_paramを名前にオーバーライド
def to_param
  name
end

def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      User.where(name: search)
    end
  end

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

   private

   def validate_password?
    password.present? || password_confirmation.present?
  end
end
