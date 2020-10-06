class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.integer :user_id, :index =>true, :null => false
      t.string :email

      t.timestamps
    end
  end
end
