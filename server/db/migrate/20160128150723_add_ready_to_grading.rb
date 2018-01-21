class AddReadyToGrading < ActiveRecord::Migration
  def change
    add_column :gradings, :ready, :boolean, :default => false
  end
end
