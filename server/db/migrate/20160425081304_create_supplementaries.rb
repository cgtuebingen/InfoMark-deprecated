class CreateSupplementaries < ActiveRecord::Migration
  def change
    create_table :supplementaries do |t|
      t.string :file
      t.references :course, index: true, foreign_key: true
      t.string :info

      t.timestamps null: false
    end
  end
end
