class ChangeColumnsNullToTrueForCalendlyToken < ActiveRecord::Migration[6.1]
  def change
    change_column_null :calendly_tokens, :user, true
    change_column_null :calendly_tokens, :organization, true
  end
end
