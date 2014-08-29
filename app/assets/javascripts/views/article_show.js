Prosody.Views.ArticleShow = Backbone.View.extend({
  template: JST["articles/show"],

  subviews: [],
  
  initialize: function () {
    this.listenTo(this.model.annotations(), 'add sync', this.render)
  },

  render: function () {
    var that = this;

    // render self

    var renderedContent = this.template({
      article: this.model
    });
    this.$el.html(renderedContent);
    
    // render new annotation form

    var formView = new Prosody.Views.AnnotationForm({
      model: new Prosody.Models.Annotation(),
      collection: this.model.annotations()
    })
    this.$(".annotation-form").html(formView.render().$el)
    
    //render annotations

    this.model.annotations().each(function (annotation) {
      var view = new Prosody.Views.AnnotationShow({
        model: annotation
      });
      that.subviews.push(view);
      that.$(".annotation-show").html()
      that.$(".annotation-show").append(view.render().$el);
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