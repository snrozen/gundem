class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.text :content
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
