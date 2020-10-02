class RemoveNullTrueToProfileTable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :profiles, :tel, false
    add_column :profiles, :post_family_name, :string, null: false
    add_column :profiles, :post_personal_name, :string, null: false
    add_column :profiles, :post_family_name_kana, :string, null: false
    add_column :profiles, :post_personal_name_kana, :string, null: false
  end
end
