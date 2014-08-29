Prosody.Collections.Annotations = Backbone.Collection.extend({
  model: Prosody.Models.Annotation,
  url: 'api/annotations',

  initialize: function (models, options) {
    this.article = options.article;
  }
})