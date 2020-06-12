class CreateEncryptions < ActiveRecord::Migration[6.0]
  def change
    create_table :encryptions do |t|
      t.string :name
      t.string :key
      t.timestamps
    end
  end
end
