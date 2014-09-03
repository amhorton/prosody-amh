json.array! @authors do |author|
  json.partial! 'api/authors/show', author: author
end