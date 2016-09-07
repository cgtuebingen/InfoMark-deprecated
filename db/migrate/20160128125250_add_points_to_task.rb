class AddPointsToTask < ActiveRecord::Migration
  def change
    add_column :exercise_tasks, :max_points, :integer
  end
end
