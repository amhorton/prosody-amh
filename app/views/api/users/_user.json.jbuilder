json.extract!(user, :id, :username, :avatar)

json.can_follow current_user.can_follow?(user)