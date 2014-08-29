Prosody.Views.ArticleShow = Backbone.View.extend({
  template: JST["articles/show"],

  render: function () {
    renderedContent = this.template({
      article: this.model
    });
    this.$el.html(renderedContent);
    return this
  }

})