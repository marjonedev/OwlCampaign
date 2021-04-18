class CampaignAddCompleteColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :complete, :boolean, null: false, default: false
  end
end
