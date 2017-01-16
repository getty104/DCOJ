class AddReferencesToPosts < ActiveRecord::Migration[5.0]
	def change
		add_reference :posts, :question
	end
end
