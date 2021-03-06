json.extract!(annotation, :id, :text, :image, :start, :end, :created_at)
json.total_votes annotation.total_votes
json.snippet annotation.snippet
json.can_upvote annotation.can_upvote?(current_user)
json.can_downvote annotation.can_downvote?(current_user)

json.user do
  json.partial! 'api/users/user', user: annotation.user
end

json.comments annotation.sorted_comments do |comment|
  json.partial! 'api/comments/comment', comment: comment
end