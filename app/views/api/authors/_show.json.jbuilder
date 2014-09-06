json.extract!(author, :first_name, :last_name, :name, :image, :info)

json.articles author.articles do |article|
  json.id article.id
  json.title article.title
  json.text article.text
  json.url article.url
  json.total_votes article.total_votes
  json.num_annotations article.annotations.length
end