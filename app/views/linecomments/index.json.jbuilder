json.array!(@linecomments) do |linecomment|
  json.extract! linecomment, :id
  json.url linecomment_url(linecomment, format: :json)
end
