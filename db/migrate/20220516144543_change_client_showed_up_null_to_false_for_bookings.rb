class ChangeClientShowedUpNullToFalseForBookings < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bookings, :client_showed_up, false
  end
end
