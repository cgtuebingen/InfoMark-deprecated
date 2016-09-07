json.array!(@exercise_sheets) do |exercise_sheet|
  json.extract! exercise_sheet, :id, :course_id, :user_id, :order, :file, :publish, :duedate, :description
  json.url exercise_sheet_url(exercise_sheet, format: :json)
end
