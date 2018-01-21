json.array!(@messages) do |message|
  json.extract! message, :id, :recipients, :subject, :body
  json.url message_url(message, format: :json)
end
