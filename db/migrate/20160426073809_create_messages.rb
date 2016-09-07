class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :recipients
      t.text :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
