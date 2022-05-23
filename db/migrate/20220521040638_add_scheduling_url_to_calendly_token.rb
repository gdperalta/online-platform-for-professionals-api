class AddSchedulingUrlToCalendlyToken < ActiveRecord::Migration[6.1]
  def change
    add_column :calendly_tokens, :scheduling_url, :string
  end
end
