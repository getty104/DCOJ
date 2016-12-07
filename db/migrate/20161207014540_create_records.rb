class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.references :user, null: false, index: true
      t.references :question, null: false, index: true
      t.foreign_key :users
      t.foreign_key :questions
      t.timestamps
    end
  end
end
