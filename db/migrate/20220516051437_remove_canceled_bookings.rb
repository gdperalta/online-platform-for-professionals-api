class RemoveCanceledBookings < ActiveRecord::Migration[6.1]
  def up
    drop_table :canceled_bookings
  end

  def down
    create_table :canceled_bookings do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :canceled_by
      t.string :canceler_type
      t.string :reason

      t.timestamps
    end
  end
end
