Prosody.Collections.Follows = Backbone.Collection.extend({
  model: Prosody.Models.Follow,
  url: "/api/follows"
})