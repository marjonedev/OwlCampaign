class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.integer :user_id
      t.text :content
      t.string :name

      t.timestamps
    end
    add_index :templates, :user_id
  end
end
