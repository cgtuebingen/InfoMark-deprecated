class AddTestingFilesToTask < ActiveRecord::Migration
  def change
    add_column :exercise_tasks, :public_test, :string
    add_column :exercise_tasks, :private_test, :string
    remove_column :exercise_tasks, :framework_file
  end
end
