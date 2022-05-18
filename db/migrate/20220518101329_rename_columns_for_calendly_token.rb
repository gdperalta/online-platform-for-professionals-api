class RenameColumnsForCalendlyToken < ActiveRecord::Migration[6.1]
  def change
    rename_column :calendly_tokens, :user, :user_uri
    rename_column :calendly_tokens, :organization, :organization_uri
  end
end
