class CampaignDatetimeType2 < ActiveRecord::Migration[6.0]
  def change
    change_column :campaigns, :datetime_send, :bigint
  end
end
