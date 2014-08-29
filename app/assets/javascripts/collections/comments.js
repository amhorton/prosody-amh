Prosody.Collections.Comments = Backbone.Collection.extend({
  model: Prosody.Models.Comment,
  url: "api/comments",

  initialize: function (models, options) {
    this.annotation = options.annotation
  }
})