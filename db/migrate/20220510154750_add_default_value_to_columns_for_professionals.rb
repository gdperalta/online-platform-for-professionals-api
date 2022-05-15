class AddDefaultValueToColumnsForProfessionals < ActiveRecord::Migration[6.1]
  def change
    change_column_default :professionals, :headline, from: nil, to: ''
    change_column_default :professionals, :office_address, from: nil, to: ''
  end
end
