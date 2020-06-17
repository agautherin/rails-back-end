class AddTypeToEncryptions < ActiveRecord::Migration[6.0]
  def change
    add_column :encryptions, :type, :string
  end
end
