json.array!(@supplementaries) do |supplementary|
  json.extract! supplementary, :id, :file, :course_id, :info
  json.url supplementary_url(supplementary, format: :json)
end
