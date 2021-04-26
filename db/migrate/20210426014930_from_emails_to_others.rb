class FromEmailsToOthers < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :from_email_id, :integer
  end
end
