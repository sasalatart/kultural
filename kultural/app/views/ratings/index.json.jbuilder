json.array!(@ratings) do |rating|
  json.extract! rating, :id, :value, :rateable_id, :rateable_type
  json.url rating_url(rating, format: :json)
end
