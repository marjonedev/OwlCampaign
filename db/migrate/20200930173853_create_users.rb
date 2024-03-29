class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email_address
      t.string :encrypted_password
      t.string :salt
      t.boolean :admin

      t.timestamps
    end
  end
end
