json.array! @annotations do |annotation|
  json.partial! 'api/annotations/annotation', annotation: annotation
end