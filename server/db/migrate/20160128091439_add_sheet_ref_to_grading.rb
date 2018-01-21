class AddSheetRefToGrading < ActiveRecord::Migration
  def change
      add_reference :gradings, :exercise_sheet, references: :exercise_sheets, index: true
      add_foreign_key :gradings, :exercise_sheets, column: :exercise_sheet_id
  end
end

