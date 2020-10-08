class ContactsAddColumns < ActiveRecord::Migration[6.0]
  def change
	add_column :contacts, :archived, :boolean, default: false
  end
end
