Prosody.Views.UserFollowBox = Backbone.View.extend({
  template: JST['users/follow_box'],

  initialize: function (options) {
    this.users = options.users;
    this.title = options.title;
  },

  render: function () {
    var renderedContent = this.template({
      users: this.users,
      title: this.title
    });

    this.$el.html(renderedContent);

    return this;
  }
})