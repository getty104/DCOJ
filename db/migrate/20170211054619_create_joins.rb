class CreateJoins < ActiveRecord::Migration[5.0]
	def change
		create_table :joins do |t|
			t.belongs_to :contest
			t.belongs_to :user
			t.timestamps
		end
	end
end
