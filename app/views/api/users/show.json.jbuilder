json.extract!(@user, :username, :avatar, :id)
json.total_votes @user.total_votes
json.can_follow current_user.can_follow?(@user)
json.can_unfollow current_user.can_unfollow?(@user)

json.followers @user.followers do |user|
  json.partial! 'api/users/user', user: user
end

json.followed_users @user.followed_users do |user|
  json.partial 'api/users/user', user: user
end

json.articles @user.articles do |article|
  json.extract!(article, :text, :title, :id)
  json.total_votes article.total_votes
  json.author_name article.author.name
end

unless @user.articles.empty?
  json.random_article do
    json.partial! 'api/articles/article', article: @user.articles.sample
  end
end

json.annotations @user.annotations do |annotation|
  json.partial! 'api/annotations/annotation', annotation: annotation
end

unless @user.annotations.empty?
  json.random_annotation do
    json.partial! 'api/annotations/annotation', annotation: @user.annotations.sample
  end
end