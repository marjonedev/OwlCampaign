class AddFromNameOnFromEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :from_emails, :name, :string
  end
end
