class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :message_id
      t.integer :user_id
      t.integer :like
      t.integer :dislike

      t.timestamps
    end
  end
end
