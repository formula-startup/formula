class CreateBigcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :bigcategories do |t|
      t.string     :name
      t.references :category_index, foreign_key: true

      t.timestamps
    end
  end
end
