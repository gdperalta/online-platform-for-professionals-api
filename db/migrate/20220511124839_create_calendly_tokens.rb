class CreateCalendlyTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :calendly_tokens do |t|
      t.references :professional, null: false, foreign_key: true
      t.string :authorization, null: false
      t.string :user, null: false
      t.string :organization, null: false

      t.timestamps
    end
  end
end
