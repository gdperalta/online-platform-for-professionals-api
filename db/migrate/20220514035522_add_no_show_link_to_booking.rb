class AddNoShowLinkToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :no_show_link, :string
  end
end
