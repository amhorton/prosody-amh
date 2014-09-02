json.results @results do |result|
  json.summary result.searchable.search_summary
  json.url result.searchable.url
end