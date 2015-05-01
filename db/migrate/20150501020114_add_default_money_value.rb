class AddDefaultMoneyValue < ActiveRecord::Migration
  def change
    change_column_default :users, :money, 200
  end
end
