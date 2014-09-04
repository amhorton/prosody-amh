Prosody.Collections.Comments = Backbone.Collection.extend({
  model: Prosody.Models.Comment,

  url: function () {
    var articleID = this.annotation.collection.article.id
    var annotationID = this.annotation.id
    return '/api/articles/' + articleID + "/annotations/" + annotationID + "/comments"
  },

  initialize: function (models, options) {
    this.annotation = options.annotation
  }
})