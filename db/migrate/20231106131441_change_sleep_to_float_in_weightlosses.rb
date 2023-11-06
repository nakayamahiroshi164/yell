class ChangeSleepToFloatInWeightlosses < ActiveRecord::Migration[7.0]
  def change
    change_column :weightlosses, :sleep, :float
  end
end
