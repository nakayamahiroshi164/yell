class ChangeWeightToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :weightlosses, :weight, :decimal, precision: 5, scale: 1

  end
end
