class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :message_id
      t.integer :user_id
      t.integer :like, :default => 0
      t.integer :dislike, :default => 0

      t.timestamps
    end
  end
end
