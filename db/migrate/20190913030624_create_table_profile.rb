class CreateTableProfile < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nickname ,null: false
      t.references :user,foreign_key: true
      t.string :avatar
      t.integer :birthyear,null: false
      t.integer :birthmonth,null: false
      t.integer :birthday,null: false
      t.string :family_name, null: false
      t.string :personal_name, null: false
      t.string :family_name_kana, null: false
      t.string :personal_name_kana, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building, null: false
      t.integer :tel ,null: false
    end
  end
end
