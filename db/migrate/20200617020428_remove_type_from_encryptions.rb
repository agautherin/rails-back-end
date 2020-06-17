class RemoveTypeFromEncryptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :encryptions, :type, :string
  end
end
