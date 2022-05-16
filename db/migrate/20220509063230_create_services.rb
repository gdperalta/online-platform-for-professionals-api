class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.references :professional, null: false, foreign_key: true
      t.string :title
      t.text :details
      t.float :min_price
      t.float :max_price

      t.timestamps
    end
  end
end
