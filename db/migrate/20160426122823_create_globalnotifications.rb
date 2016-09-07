class CreateGlobalnotifications < ActiveRecord::Migration
  def change
    create_table :globalnotifications do |t|
      t.text :body
      t.datetime :start
      t.datetime :ends
      t.integer :visibility

      t.timestamps null: false
    end
  end
end
