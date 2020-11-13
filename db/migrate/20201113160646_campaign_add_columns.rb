class CampaignAddColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :status, :string, default: 'draft'
    add_column :campaigns, :instant, :boolean, default: false
    add_column :campaigns, :name, :string
  end
end
