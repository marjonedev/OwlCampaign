class CreateFromEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :from_emails do |t|
      t.string :email_address
      t.integer :user_id, :index =>true, :null => false
      t.boolean :confirmed, :default => false
      t.string :confirm_token
      t.boolean :default, :default => false

      t.timestamps
    end
  end
end
