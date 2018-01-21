class CreateLinecomments < ActiveRecord::Migration
  def change
    create_table :linecomments do |t|
      t.references :submission, index: true, foreign_key: true
      t.string :file_name
      t.integer :line
      t.string :comment
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
