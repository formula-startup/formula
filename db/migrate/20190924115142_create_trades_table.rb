class CreateTradesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :product, foreign_key: true
      t.references :buyer, foreign_key: {to_table: :users}
      t.references :seller, foreign_key: {to_table: :users}
    end
  end
end
