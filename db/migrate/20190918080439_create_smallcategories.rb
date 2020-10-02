class CreateSmallcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :smallcategories do |t|
      t.string     :name
      t.references :bigcategory, foreign_key: true

      t.timestamps
    end
  end
end
