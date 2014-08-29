Prosody.Views.ArticleShow = Backbone.View.extend({
  template: JST["articles/show"],

  render: function () {
    console.log("model in the view:", this.model)
    renderedContent = this.template({
      article: this.model
    });
    this.$el.html(renderedContent);
    return this
  }

})