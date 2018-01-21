class AddRootFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :root, :boolean,  null: false, default: false
  end
end
