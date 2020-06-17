class RemoveNameFromEncryptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :encryptions, :name, :string
  end
end
