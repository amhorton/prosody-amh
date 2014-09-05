Prosody.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  subviews: [],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
  },

  events: {
    'click .follow-button': 'follow',
    'click .unfollow-button': 'unfollow',
    'click .follow-box': 'renderFollowBox',
    'click .index': 'renderIndex'
  },


  render: function () {
    var renderedContent = this.template({
      user: this.model
    });

    this.$el.html(renderedContent);
    return this
  },

  follow: function (event) {
    var that = this

    event.preventDefault();

    $.ajax({
      type: "POST",
      url: "/api/follows",
      data: {followed_id: that.model.id},
      success: function(data){
        console.log("data:", data)
        that.model.fetch()
      }
    });
  },

  unfollow: function (event) {
    var that = this

    event.preventDefault();

    $.ajax({
      type: "DELETE",
      url: "/api/follows",
      data: {followed_id: that.model.id},
      success: function(data){
        that.model.fetch()
      }
    });
  },

  renderFollowBox: function (event) {
    if ($(event.currentTarget).hasClass("followers")) {
      var title = "All Followers"
      var users = this.model.get('followers')
    } else {
      var title = "All Followed Users"
      var users = this.model.get('followed_users')
    }

    var view = new Prosody.Views.UserFollowBox({
      title: title,
      users: users
    });

    this.subviews.push(view);

    $(".content-container").html(view.render().$el);
  },

  renderIndex: function (event) {
    if ($(event.currentTarget).hasClass("index-article")) {
      var title = "All Articles"
      var indexables = this.model.get('articles')
    } else {
      var title = "All<br>Anno<br>tations"
      var indexables = this.model.get('annotations')
    }

    var view = new Prosody.Views.UserIndex({
      title: title,
      indexables: indexables
    });

    this.subviews.push(view);

    $(".content-container").html(view.render().$el);
  },

  remove: function () {
    this.subviews.forEach(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this)
  }
})