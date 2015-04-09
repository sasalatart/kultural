json.array!(@users) do |user|
  json.extract! user, :id, :name, :password, :mail, :phone, :birthday, :gender
  json.url user_url(user, format: :json)
end
