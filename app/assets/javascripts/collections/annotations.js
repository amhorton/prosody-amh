Prosody.Collections.Annotations = Backbone.Collection.extend({
  model: Prosody.Models.Annotation,
  url: function () {
    return '/api/articles/' + this.article.id + "/annotations"
  },

  initialize: function (models, options) {
    this.article = options.article;
  }
})