json.array!(@users) do |user|
  json.extract! user, :id, :name, :password, :mail, :phone, :birthday, :male
  json.url user_url(user, format: :json)
end
