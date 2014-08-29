json.(@article, :id, :title, :created_at, :updated_at, :year, :text)

json.author do
  json.partial! 'api/authors/author', author: @article.author
end

json.annotations do
  json.partial! partial: '/api/annotations/annotation', collection: @article.annotations, as: :annotation
end

# json.annotations @article.annotations do |annotation|
#   json.id annotation.id
#   json.text annotation.text
#   json.image annotation.image
#   json.start annotation.start
#   json.end annotation.end
#   json.created_at annotation.created_at
#
#   json.comments annotation.comments do |comment|
#     json.extract! comment, :user_id, :text, :annotation_id, :created_at, :updated_at
#   end
# end



#json.partial! partial: 'posts/post', collection: @posts, as: :post