Prosody.Views.SearchResults = Backbone.View.extend({
  template: JST["searches/results"],

  initialize: function (options) {
    this.results = options.results
  },

  render: function () {
    var renderedContent = this.template({
      results: this.results
    });
    this.$el.html(renderedContent);

    return this;
  }
});