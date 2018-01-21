class AddRenamePic < ActiveRecord::Migration
  def change
  	rename_column :users, :pic, :avatar
  end
end
