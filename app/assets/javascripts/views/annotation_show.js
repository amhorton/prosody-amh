Prosody.Views.AnnotationShow = Backbone.View.extend({
  template: JST["annotations/show"],

  subviews: [],

  render: function () {
    var that = this;

    var renderedContent = this.template({
      annotation: this.model
    });
    this.$el.html(renderedContent);

    this.model.comments().each(function (annotation) {
      var view = new Prosody.Views.CommentShow({
        model: annotation
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