Prosody.Views.AuthorShow = Backbone.View.extend({
  template: JST['authors/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
  },

  render: function () {
    var renderedContent = this.template({
      author: this.model
    });

    this.$el.html(renderedContent);
    return this
  }
})