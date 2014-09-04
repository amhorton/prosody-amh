json.extract!(article, :title, :year, :id)

json.text article.text_with_links

json.total_votes article.total_votes
json.can_upvote article.can_upvote?(current_user)
json.can_downvote article.can_downvote?(current_user)

json.user do
  json.partial! 'api/users/user', user: article.user
end

json.author do
  json.partial! 'api/authors/author', author: article.author
end

json.annotations article.annotations do |annotation|
  json.partial! 'api/annotations/annotation', annotation: annotation
end