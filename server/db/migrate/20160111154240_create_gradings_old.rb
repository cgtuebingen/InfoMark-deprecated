class CreateGradingsOld < ActiveRecord::Migration
  def change
    create_table :submission_infos do |t|
      t.references :user, index: true, foreign_key: true
      t.references :exercise_task, index: true, foreign_key: true
      t.text :log

      t.timestamps null: false
    end
  end
end
