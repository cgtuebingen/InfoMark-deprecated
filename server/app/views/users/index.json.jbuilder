json.array!(User.all) do |user|
  json.extract! user, :id
  json.extract! user, :name
  json.extract! user, :subject
  json.extract! user, :semester
  json.extract! user, :student_number
end
