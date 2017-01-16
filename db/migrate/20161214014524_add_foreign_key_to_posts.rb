class AddForeignKeyToPosts < ActiveRecord::Migration[5.0]
	def change
		add_foreign_key :posts, :questions 
	end
end
