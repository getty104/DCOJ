class CreateJoins < ActiveRecord::Migration[5.0]
	def change
		create_table :joins do |t|
			t.belongs_to :contest, index: true
			t.belongs_to :user, index: true
			t.timestamps
		end
		add_foreign_key :joins, :contests
		add_foreign_key :joins, :users  
	end
end
