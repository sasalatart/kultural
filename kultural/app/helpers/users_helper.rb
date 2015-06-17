module UsersHelper
  def gender(user)
    user.male ? "Male" : "Female"
  end
end
