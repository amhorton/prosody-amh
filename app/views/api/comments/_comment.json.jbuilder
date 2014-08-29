json.extract! comment, :user_id, :text, :annotation_id, :created_at, :updated_at
json.total_votes comment.total_votes

json.user do
  json.partial! 'api/users/user', user: comment.user
end