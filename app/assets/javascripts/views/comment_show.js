Prosody.Views.CommentShow = Backbone.View.extend({
  template: JST["comments/show"],
  
  subviews: [],
  
  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var renderedContent = this.template({
      comment: this.model
    });
    this.$el.html(renderedContent);
	
	//render vote buttons
	
    if (Prosody.currentUserId) {

      var voteButtonView = new Prosody.Views.VoteButtons({
        model: this.model,
        votableType: "Comment"
      });

      this.subviews.push(voteButtonView)
      this.$('.vote-buttons').html(voteButtonView.render().$el)
    }
	
    return this;
  },
  
  remove: function () {
    this.subviews.forEach(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this)
  }
})