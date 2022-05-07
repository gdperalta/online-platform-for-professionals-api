class CreateProfessionals < ActiveRecord::Migration[6.1]
  def change
    create_table :professionals do |t|
      t.references :user
      t.string :field
      t.string :license_number
      t.string :office_address
      t.text :headline

      t.timestamps
    end
  end
end
