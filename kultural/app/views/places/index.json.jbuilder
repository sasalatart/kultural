json.array!(@places) do |place|
  json.extract! place, :id, :name, :description, :x, :y, :owner_id, :owner_type
  json.url place_url(place, format: :json)
end
