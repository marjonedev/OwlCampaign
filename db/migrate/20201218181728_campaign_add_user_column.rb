class CampaignAddUserColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :user_id, :integer, null: false
  end
end
