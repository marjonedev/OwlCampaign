class ChangeFromEmailonCampaign < ActiveRecord::Migration[6.0]
  def change
    remove_column :campaigns, :from_email
    add_column :campaigns, :from_email_address, :string
  end
end
