class User < ApplicationRecord
    include Resonatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :authentication_keys => [:login]
         
  mount_uploader :image, ImageUploader
  has_many :create_questions, class_name: "Question", foreign_key: 'created_user_id', dependent: :destroy
  has_and_belongs_to_many :questions
  has_many :records, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :contests, dependent: :destroy
  validates :account, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  attr_accessor :login
#to_paramを名前にオーバーライド
def to_param
  name
end

def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      User.where(name: search)
    end
  end

    def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["name = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

   private

   def validate_password?
    password.present? || password_confirmation.present?
  end
end
