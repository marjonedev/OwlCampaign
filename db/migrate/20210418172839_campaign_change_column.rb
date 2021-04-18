class CampaignChangeColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :campaigns, :complete
    change_column_default :campaigns, :status, "incomplete"
  end
end
