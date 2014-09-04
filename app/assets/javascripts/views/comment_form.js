Prosody.Views.CommentForm = Backbone.View.extend({
  template: JST["comments/form"],

  events: {
    'submit .new-comment': 'submit'
  },

  render: function () {
    var renderedContent = this.template({
      comment: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  submit: function (event) {
    var that = this;

    event.preventDefault();

    var attrs = $(event.target).serializeJSON();

    this.collection.create(attrs, {
      success: function (data) {
        that.collection.fetch();
      },
      wait: true
    });
  },
})