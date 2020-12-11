class CampaignDateTime < ActiveRecord::Migration[6.0]
  def change
    rename_column :campaigns, :date_send, :datetime_send
    remove_column :campaigns, :time_send
  end
end
