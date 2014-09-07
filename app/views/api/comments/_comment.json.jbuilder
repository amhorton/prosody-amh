json.extract! comment, :id, :user_id, :text, :annotation_id, :created_at, :updated_at
json.total_votes comment.total_votes
json.can_upvote comment.can_upvote?(current_user)
json.can_downvote comment.can_downvote?(current_user)

json.user do
  json.partial! 'api/users/user', user: comment.user
end