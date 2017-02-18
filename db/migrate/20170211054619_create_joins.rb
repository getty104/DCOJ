class CreateJoins < ActiveRecord::Migration[5.0]
	def change
		create_table :joins do |t|
			t.references :contest
			t.references :user
			t.timestamps
		end
		add_foreign_key :joins, :contests
		add_foreign_key :joins, :users  
	end
end
