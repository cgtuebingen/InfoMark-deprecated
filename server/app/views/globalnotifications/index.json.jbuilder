json.array!(@globalnotifications) do |globalnotification|
  json.extract! globalnotification, :id, :body, :start, :ends, :visibility
  json.url globalnotification_url(globalnotification, format: :json)
end
