class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :file
      t.references :course, index: true, foreign_key: true
      t.datetime :publish
      t.boolean :public
      t.date :lecture
      t.string :info
      t.string :title

      t.timestamps null: false
    end
  end
end
