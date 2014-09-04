Prosody.Views.ArticleForm = Backbone.View.extend({
  template: JST['articles/form'],

  events: {
    'submit .new-article': 'submit'
  },

  render: function () {
    var renderedContent = this.template({});
    this.$el.html(renderedContent);

    return this;
  },

  submit: function (event) {
    var that = this;

    event.preventDefault();

    var attrs = $(event.target).serializeJSON();

    Prosody.articles.create(attrs, {
      success: function (data) {
        Backbone.history.navigate("/articles/" + data.id, {trigger: true});
      },
      wait: true
    });
  },
})