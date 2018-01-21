class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :subtitle
      t.string :description
      t.date :begin
      t.date :termination

      t.timestamps null: false
    end
  end
end
