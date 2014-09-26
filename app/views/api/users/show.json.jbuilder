require 'wikipedia'

json.extract!(@user, :username, :avatar, :id)
json.total_votes @user.total_votes

if !!current_user
  json.can_follow current_user.can_follow?(@user)
  json.can_unfollow current_user.can_unfollow?(@user)
end

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

json.annotations @user.annotations.reverse do |annotation|
  json.text annotation.text
  json.url annotation.url
  json.title annotation.title
end