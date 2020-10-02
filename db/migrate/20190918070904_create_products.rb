class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :title
      t.string     :text
      t.string     :fresh_status
      t.references :user, foreign_key: true
      t.string     :sell_status, default:"出品中"
      t.integer    :price

      # 配送関係
      t.string :deliver_person
      t.string :from_area
      t.string :deliver_leadtime
      t.string :deliver_way

      t.timestamps
    end
  end
end
