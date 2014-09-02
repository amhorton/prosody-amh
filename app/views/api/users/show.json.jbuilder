json.extract!(@user, :username, :avatar, :id)
json.total_votes @user.total_votes

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

json.random_article do
  json.partial! 'api/articles/article', article: @user.articles.sample
end

json.annotations @user.annotations do |annotation|
  json.partial! 'api/annotations/annotation', annotation: annotation
end

json.random_annotation do
  json.partial! 'api/annotations/annotation', annotation: @user.annotations.sample
end