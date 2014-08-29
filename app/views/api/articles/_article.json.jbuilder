json.extract!(article, :title, :text, :year, :id)
json.total_votes article.total_votes

json.user do
  json.partial! 'api/users/user', user: article.user
end

json.author do
  json.partial! 'api/authors/author', author: article.author
end

json.annotations article.annotations do |annotation|
  json.partial! 'api/annotations/annotation', annotation: annotation
end