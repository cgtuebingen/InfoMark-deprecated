json.array!(@exercise_tasks) do |exercise_task|
  json.extract! exercise_task, :id
  json.url exercise_task_url(exercise_task, format: :json)
end
