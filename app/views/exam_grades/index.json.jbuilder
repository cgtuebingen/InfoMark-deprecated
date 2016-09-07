json.array!(@exam_grades) do |exam_grade|
  json.extract! exam_grade, :id, :points, :mark, :info, :user_id, :exam_id
  json.url exam_grade_url(exam_grade, format: :json)
end
