json.(annotation, :text, :article_id, :user_id, :image)

json.array! annotation.comments, partial: 'api/comments/comment', as: :comment