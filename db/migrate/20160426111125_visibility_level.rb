class VisibilityLevel < ActiveRecord::Migration
  def change
    add_column :supplementaries, :visibility, :integer
  end
end
