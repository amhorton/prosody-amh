json.extract!(@user, :username, :avatar, :id)
json.total_votes @user.total_votes
json.can_follow current_user.can_follow?(@user)
json.can_unfollow current_user.can_unfollow?(@user)

json.followers @user.followers do |user|
  json.partial! 'api/users/user', user: user
end

json.followed_users @user.followed_users do |user|
  json.partial! 'api/users/user', user: user
end

json.articles @user.articles do |article|
  json.extract!(article, :text, :title, :id)
  json.total_votes article.total_votes
  json.author_name article.author.name
  json.url article.url
end

json.annotations @user.annotations do |annotation|
  json.extract(annotation, :text)
  json.url annotation.url
end