class RenameClientAttendedToClientShowedUpForBookings < ActiveRecord::Migration[6.1]
  def change
    rename_column :bookings, :client_attended, :client_showed_up
  end
end
