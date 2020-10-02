class CreateSmallcategoriesHasSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :smallcategories_has_sizes do |t|
      t.references :smallcategory, foreign_key:true
      t.references :size,          foreign_key: true
      t.timestamps
    end
  end
end
