json.array!(@slides) do |slide|
  json.extract! slide, :id, :file, :course_id, :publish, :public, :lecture, :info, :title
  json.url slide_url(slide, format: :json)
end
