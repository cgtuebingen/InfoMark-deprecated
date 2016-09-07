class AddBoniInfoToMark < ActiveRecord::Migration
  def change
    add_column :exams, :bonus, :text
  end
end
