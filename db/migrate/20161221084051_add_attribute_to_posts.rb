class AddAttributeToPosts < ActiveRecord::Migration[5.0]
	def change
		add_column :posts, :attribute, :integer
	end
end
