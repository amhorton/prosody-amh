Prosody.Views.UserIndex = Backbone.View.extend({
  template: JST['users/index'],

  initialize: function (options) {
    this.indexables = options.indexables;
    this.title = options.title;
  },

  render: function () {
    var renderedContent = this.template({
      indexables: this.indexables,
      title: this.title
    });

    this.$el.html(renderedContent);

    return this;
  }
})