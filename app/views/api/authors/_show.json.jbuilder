json.extract!(author, :first_name, :last_name, :name, :image, :info)

json.articles author.articles do |article|
  json.id article.id
  json.title article.title
  json.url article.url
end