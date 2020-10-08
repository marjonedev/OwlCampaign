class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.integer :emaillist_id
      t.integer :template_id
      t.string :from
      t.string :subject
      t.text :content
      t.date :date_send
      t.time :time_send

      t.timestamps
    end
    add_index :campaigns, :emaillist_id
    add_index :campaigns, :template_id
  end
end
