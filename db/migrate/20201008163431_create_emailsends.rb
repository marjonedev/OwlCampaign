class CreateEmailsends < ActiveRecord::Migration[6.0]
  def change
    create_table :emailsends do |t|
      t.integer :contact_id
      t.integer :campaign_id
      t.string :status
      t.string :status_message
      t.boolean :bounced

      t.timestamps
    end
    add_index :emailsends, :contact_id
    add_index :emailsends, :campaign_id
  end
end
