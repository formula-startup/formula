class RemoveProfileColumnNickname < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :nickname
    add_column :users, :nickname , :string, nil: false
  end
end
