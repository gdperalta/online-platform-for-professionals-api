class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :professional, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.boolean :client_attended
      t.string :status
      t.string :event_uuid

      t.timestamps
    end
  end
end
