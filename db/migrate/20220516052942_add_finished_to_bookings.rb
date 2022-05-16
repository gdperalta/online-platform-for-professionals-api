class AddFinishedToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :finished, :boolean
  end
end
