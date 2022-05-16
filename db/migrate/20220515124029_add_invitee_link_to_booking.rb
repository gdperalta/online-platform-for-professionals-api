class AddInviteeLinkToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :invitee_link, :string
  end
end
