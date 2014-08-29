json.extract!(annotation, :id, :text, :image, :start, :end, :created_at)
json.total_votes annotation.total_votes

json.user do
  json.partial! 'api/users/user', user: annotation.user
end

json.comments annotation.comments do |comment|
  json.partial! 'api/comments/comment', comment: comment
end