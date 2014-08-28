json.(article, :title, :text, :year, :user_id)

json.author do
  json.first_name = article.author.first_name
  json.last_name = article.author.last_name
end

json.array! article.annotations, partial: 'api/annotations/annotation', as: :annotation