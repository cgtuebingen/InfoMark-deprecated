json.array!(@exams) do |exam|
  json.extract! exam, :id, :title, :course_id, :date, :info
  json.url exam_url(exam, format: :json)
end
