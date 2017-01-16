class CreateBlocks < ActiveRecord::Migration[5.0]
	def change
		create_table :blocks do |t|
			t.integer :user_id
			t.integer :target_user_id

			t.timestamps
		end
		add_index :blocks, [:user_id, :target_user_id], unique: true
	end
end
