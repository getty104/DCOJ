class CreatePosts < ActiveRecord::Migration[5.0]
	def change
		create_table :posts do |t|
			t.text :content
			t.references :user, null: false, index: true
			t.foreign_key :users
			t.timestamps
		end
	end
end
