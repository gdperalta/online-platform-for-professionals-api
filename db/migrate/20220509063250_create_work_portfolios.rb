class CreateWorkPortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :work_portfolios do |t|
      t.references :professional, null: false, foreign_key: true
      t.string :title
      t.text :details

      t.timestamps
    end
  end
end
