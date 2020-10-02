class CreateCategoryIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :category_indices do |t|
      t.string      :name

      t.timestamps
    end
  end
end
