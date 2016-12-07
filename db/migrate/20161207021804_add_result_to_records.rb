class AddResultToRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :records, :result, :string
  end
end
