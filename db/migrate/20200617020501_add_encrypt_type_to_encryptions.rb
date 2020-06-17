class AddEncryptTypeToEncryptions < ActiveRecord::Migration[6.0]
  def change
    add_column :encryptions, :encrypt_type, :string
  end
end
