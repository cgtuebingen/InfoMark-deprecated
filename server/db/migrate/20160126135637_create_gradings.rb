class CreateGradings < ActiveRecord::Migration
  def change
 
    create_table :gradings do |t|
      t.references :submission
      t.text :feedback
      t.integer :points

      t.timestamps null: false

      
    end

    add_reference :gradings, :tutor, references: :users, index: true
    add_foreign_key :gradings, :users, column: :tutor_id
  end
end
