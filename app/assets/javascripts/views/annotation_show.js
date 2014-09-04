Prosody.Views.AnnotationShow = Backbone.View.extend({
  template: JST["annotations/show"],

  subviews: [],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.comments(), 'sync add', this.render)
  },

  render: function () {
    var that = this;

    var renderedContent = this.template({
      annotation: this.model
    });
    this.$el.html(renderedContent);

    if (Prosody.currentUserId) {
      // render comment form

      var formView = new Prosody.Views.CommentForm({
        collection: this.model.comments()
      });

      this.subviews.push(formView);
      this.$('.new-comment').html(formView.render().$el)

      //render vote buttons

      var voteButtonView = new Prosody.Views.VoteButtons({
        model: this.model,
        votableType: "Annotation"
      });

      this.subviews.push(voteButtonView)
      this.$('.vote-buttons').html(voteButtonView.render().$el)
    }

    this.model.comments().each(function (comment) {
      var view = new Prosody.Views.CommentShow({
        model: comment
      });
      that.subviews.push(view);
      that.$(".comments").html()
      that.$('.comments').append(view.render().$el);
    })
    return this;
  },

  remove: function () {
    this.subviews.forEach(function (subview) {
      subview.remove();
    });

    Backbone.View.prototype.remove.call(this)
  }


})