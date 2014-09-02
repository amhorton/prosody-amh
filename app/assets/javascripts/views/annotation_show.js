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

    var formView = new Prosody.Views.CommentForm({
      collection: this.model.comments()
    });
    
    this.subviews.push(formView);
    this.$('.new-comment').html(formView.render().$el)

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