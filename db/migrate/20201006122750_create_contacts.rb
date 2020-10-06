class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.integer :user_id, :index =>true, :null => false
      t.string :email, :null => false
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
