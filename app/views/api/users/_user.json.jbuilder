json.extract!(user, :id, :username, :avatar)

if !!current_user
  json.can_follow current_user.can_follow?(user)
end