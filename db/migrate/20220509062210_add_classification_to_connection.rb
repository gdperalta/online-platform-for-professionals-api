class AddClassificationToConnection < ActiveRecord::Migration[6.1]
  def change
    add_column :connections, :classification, :string, null: false
  end
end
