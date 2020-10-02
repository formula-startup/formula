class RemoveNullTrue < ActiveRecord::Migration[5.2]
  def change
    change_column_null :profiles, :tel, true
  end
end
