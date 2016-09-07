json.array!(@ratings) do |g|
  json.extract! g, :id
  json.extract! g, :user_id
  json.extract! g, :rating
  json.extract! g, :course_group_id
end
