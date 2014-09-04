Prosody.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
  },

  events: {
    'click .follow-button': 'follow',
    'click .unfollow-button': 'unfollow'
  },


  render: function () {
    console.log("this.model:", this.model)
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
  }
})