class CreatePointsCaches < ActiveRecord::Migration
  def change
    create_table :points_caches do |t|
      t.references :user, index: true, foreign_key: true
      t.references :exercise_sheet, index: true, foreign_key: true
      t.integer :points

      t.timestamps null: false
    end
  end
end
