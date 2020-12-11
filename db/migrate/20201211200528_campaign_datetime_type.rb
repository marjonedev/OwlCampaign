class CampaignDatetimeType < ActiveRecord::Migration[6.0]
  def change
    change_column :campaigns, :datetime_send, :integer
  end
end
