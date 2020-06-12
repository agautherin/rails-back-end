class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :message_text
      t.integer :chatroom_id
      t.integer :user_id
      t.integer :encryption_id
      t.timestamps
    end
  end
end
