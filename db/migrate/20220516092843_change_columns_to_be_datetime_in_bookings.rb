class ChangeColumnsToBeDatetimeInBookings < ActiveRecord::Migration[6.1]
  def up
    change_column :bookings, :start_time, :datetime
    change_column :bookings, :end_time, :datetime
  end

  def down
    change_column :bookings, :start_time, :date
    change_column :bookings, :end_time, :date
  end
end
