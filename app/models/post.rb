class Post < ApplicationRecord
	belongs_to :question, optional: true
	belongs_to :user, optional: true
	belongs_to :contest, optional: true
end
