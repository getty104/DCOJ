class Post < ApplicationRecord
	belongs_to :question, optional: true
	belongs_to :user, optional: true
	belongs_to :contest, optional: true

	scope :follows_post, -> (current_user){ where(user_id: current_user.following.ids).or(Post.where(user_id: current_user.id)) }
end
